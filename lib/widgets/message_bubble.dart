import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  final bool isFirstInSequence;
  final String? userImage;

  final String? username;
  final String message;


  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withAlpha(51),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200]?.withAlpha(127), // Subtle background
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Text(
                        username!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600, // Slightly lighter bold
                          color: Theme.of(context).textTheme.bodyMedium?.color ??
                              Colors.black87, // Use theme color
                          fontSize: 12, // Reduced font size
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: isMe
                          ? LinearGradient(
                        colors: [
                          Colors.grey[200]!,
                          Colors.grey[300]!,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )
                          : null,
                      color:
                      isMe ? null : theme.colorScheme.secondary.withAlpha(200),
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(16), // Slightly larger radius
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(16), // Slightly larger radius
                        bottomLeft: const Radius.circular(16),
                        bottomRight: const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Subtle shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.withAlpha(26),
                        width: 0.5,
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}