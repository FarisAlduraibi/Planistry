import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/constants.dart';

class FlashCardsScreen extends StatefulWidget {
  @override
  _FlashCardsScreenState createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  // List of flash cards
  final List<FlashCard> flashCards = [
    FlashCard(
      front: 'Linked List',
      back: 'A linked list is a linear data structure composed of nodes, where each node contains data and a reference (pointer) to the next node in the sequence.',
      color: Colors.blue,
      letter: 'L',
    ),
    FlashCard(
      front: 'Pointer',
      back: 'A pointer is a variable that stores the memory address of another variable, allowing direct access and manipulation of that variable\'s data.',
      color: Colors.blue,
      letter: 'P',
    ),
    FlashCard(
      front: 'Array',
      back: 'An array is a collection of elements stored at contiguous memory locations, accessible using an index.',
      color: Colors.blue,
      letter: 'A',
    ),
    FlashCard(
      front: 'Stack',
      back: 'A stack is a linear data structure that follows the Last In First Out (LIFO) principle.',
      color: Colors.blue,
      letter: 'S',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CS 432',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              'Flash cards 01',
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: flashCards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FlipCard(flashCard: flashCards[index]),
          );
        },
      ),
    );
  }
}

class FlashCard {
  final String front;
  final String back;
  final Color color;
  final String letter;

  FlashCard({
    required this.front,
    required this.back,
    required this.color,
    required this.letter,
  });
}

class FlipCard extends StatefulWidget {
  final FlashCard flashCard;

  const FlipCard({Key? key, required this.flashCard}) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  bool isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: math.pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -math.pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (isFrontVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isFrontVisible = !isFrontVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackColor = isDark ? Colors.grey[850] : Colors.white;
    final backTextColor = isDark ? Colors.white70 : widget.flashCard.color;

    return GestureDetector(
      onTap: _toggleCard,
      child: Stack(
        children: [
          // Back card
          AnimatedBuilder(
            animation: _backRotation,
            builder: (context, child) {
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_backRotation.value);
              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: Visibility(
                  visible: !isFrontVisible,
                  child: _buildCardContent(isBack: true, cardBackColor: cardBackColor, backTextColor: backTextColor),
                ),
              );
            },
          ),

          // Front card
          AnimatedBuilder(
            animation: _frontRotation,
            builder: (context, child) {
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_frontRotation.value);
              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: Visibility(
                  visible: isFrontVisible,
                  child: _buildCardContent(isBack: false, cardBackColor: cardBackColor, backTextColor: backTextColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent({required bool isBack, required Color? cardBackColor, required Color backTextColor}) {
    return Container(
      height: isBack ? 120 : 100,
      decoration: BoxDecoration(
        color: isBack ? cardBackColor : widget.flashCard.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: isBack
          ? Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          widget.flashCard.back,
          style: TextStyle(
            fontSize: 14,
            color: backTextColor,
          ),
        ),
      )
          : Stack(
        children: [
          Center(
            child: Text(
              widget.flashCard.front,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}