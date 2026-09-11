import 'package:flutter/material.dart';

class PostSkeleton extends StatelessWidget {
  const PostSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8E8E8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: const Color(0xFFE8E8E8),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 10,
                      width: 120,
                      color: const Color(0xFFF1F1F1),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Image placeholder
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFECECEC),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 12),

          // Actions / text placeholders
          Row(
            children: [
              Container(
                width: 28,
                height: 14,
                color: const Color(0xFFE8E8E8),
              ),
              const SizedBox(width: 8),
              Container(
                width: 28,
                height: 14,
                color: const Color(0xFFE8E8E8),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 14,
                  color: const Color(0xFFF1F1F1),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            height: 12,
            width: double.infinity,
            color: const Color(0xFFF1F1F1),
          ),
        ],
      ),
    );
  }
}
