# Cloud Server Security Assessment Framework

A Bash-based security assessment tool for performing basic
security checks on Linux/cloud server environments.

## Project Objective

The project demonstrates how Bash can be used to automate
basic cloud-server security assessment and security decision logic.

## Security Checks

### Identity
- Current user identification
- Target user validation

### Authentication
- Failed login risk classification
- CRITICAL / HIGH / MEDIUM / LOW severity

### Network Exposure
- Listening network service visibility

### Reporting
- Consolidated security assessment output
- Security-oriented findings and recommended actions

## Detection Rules

- Root user OR more than 10 failed attempts -> CRITICAL
- Admin user AND more than 5 failed attempts -> HIGH
- More than 3 failed attempts -> MEDIUM
- Otherwise -> LOW

## Technologies

- Bash
- Linux
- Vim
- whoami
- hostname
- uptime
- ss
