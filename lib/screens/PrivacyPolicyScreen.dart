import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme_controller.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final ThemeController _themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness and colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final cardColor = Theme.of(context).cardTheme.color!;

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.blue),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy & Policy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'How we protect your data',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Privacy icon
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.privacy_tip_outlined,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 24),

                _buildSectionTitle('Privacy Policy', textColor),
                _buildLastUpdated('Last updated: May 6, 2025', secondaryTextColor),
                SizedBox(height: 16),

                _buildParagraph(
                  'This Privacy Policy describes how we collect, use, and share your personal information when you use our application.',
                  secondaryTextColor,
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Information We Collect', textColor),
                SizedBox(height: 12),

                _buildSubsectionTitle('Personal Information', textColor),
                _buildParagraph(
                  'We may collect personal information that you provide directly to us, such as your name, email address, phone number, university, major, and other academic information when you register for an account, set up your profile, or communicate with us.',
                  secondaryTextColor,
                ),

                SizedBox(height: 16),
                _buildSubsectionTitle('Usage Information', textColor),
                _buildParagraph(
                  'We automatically collect certain information about your device and how you interact with our application, including:',
                  secondaryTextColor,
                ),
                _buildBulletPoint('Study habits and completed tasks', secondaryTextColor),
                _buildBulletPoint('Time spent on different features', secondaryTextColor),
                _buildBulletPoint('App performance and error reports', secondaryTextColor),
                _buildBulletPoint('Device information such as operating system and version', secondaryTextColor),

                SizedBox(height: 24),
                _buildSectionTitle('How We Use Your Information', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'We use the information we collect to:',
                  secondaryTextColor,
                ),
                _buildBulletPoint('Provide, maintain, and improve our services', secondaryTextColor),
                _buildBulletPoint('Personalize your experience and deliver content relevant to your interests', secondaryTextColor),
                _buildBulletPoint('Send notifications about updates, features, or study reminders', secondaryTextColor),
                _buildBulletPoint('Monitor and analyze trends, usage, and activities in connection with our application', secondaryTextColor),
                _buildBulletPoint('Detect, investigate, and prevent fraudulent transactions and other illegal activities', secondaryTextColor),

                SizedBox(height: 24),
                _buildSectionTitle('Data Sharing and Disclosure', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'We do not share or sell your personal information to third parties for marketing purposes. We may share your information in the following circumstances:',
                  secondaryTextColor,
                ),
                _buildBulletPoint('With service providers who perform services on our behalf', secondaryTextColor),
                _buildBulletPoint('To comply with legal obligations', secondaryTextColor),
                _buildBulletPoint('To protect and defend our rights and property', secondaryTextColor),
                _buildBulletPoint('With your consent or at your direction', secondaryTextColor),

                SizedBox(height: 24),
                _buildSectionTitle('Data Security', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.',
                  secondaryTextColor,
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Your Rights', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'Depending on your location, you may have certain rights regarding your personal information, including:',
                  secondaryTextColor,
                ),
                _buildBulletPoint('Access to your personal information', secondaryTextColor),
                _buildBulletPoint('Correction of inaccurate or incomplete information', secondaryTextColor),
                _buildBulletPoint('Deletion of your personal information', secondaryTextColor),
                _buildBulletPoint('Restriction or objection to certain processing activities', secondaryTextColor),

                SizedBox(height: 24),
                _buildSectionTitle('Changes to This Policy', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'We may update this Privacy Policy from time to time to reflect changes to our practices or for other operational, legal, or regulatory reasons. We will notify you of any material changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
                  secondaryTextColor,
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Contact Us', textColor),
                SizedBox(height: 12),
                _buildParagraph(
                  'If you have any questions about this Privacy Policy or our data practices, please contact us at:',
                  secondaryTextColor,
                ),
                SizedBox(height: 8),
                _buildContactInfo('Email: privacy@studyapp.com', textColor),
                _buildContactInfo('Address: 123 Education Street, Learning City, 10001', textColor),

                SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildSubsectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildLastUpdated(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: color,
      ),
    );
  }

  Widget _buildParagraph(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: color,
        height: 1.5,
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: color, fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: color,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}