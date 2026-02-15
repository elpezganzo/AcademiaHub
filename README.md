# Academy Hub

**Your app for the global school portal – 100 % configurable for any educational system.**  

A fully customizable, open‑source replacement for Lanis Mobile, rebuilt to serve academies, schools, and districts around the world.

---

## 📚 Overview

Academy Hub provides a modular suite of tools:

- **Dashboard** – personalized home screen with announcements, timetables, grades, and quick actions.  
- **Timetable & Scheduling** – flexible period lengths, holiday calendars, room booking.  
- **Learning Management** – courses, assignments, quizzes, and grading schemes that you define.  
- **Communication** – secure messaging, push notifications, discussion boards.  
- **Attendance & Behaviour** – sign‑in/out, absence tracking, behaviour logs.  
- **Grades & Reporting** – custom weighting, printable reports, export to PDF/CSV.  
- **Finance & Billing** – tuition, cafeteria accounts, library fines, multi‑currency support.  
- **Library & Resources** – catalog search, e‑book lending, reservation system.  
- **Extracurricular & Events** – clubs, sports, field trips, voting.  
- **Analytics & Insights** – usage stats, performance trends, predictive alerts.  
- **Integrations** – SIS, HR, ERP, third‑party content providers (YouTube, Khan Academy, …).

Every module is driven by a **declarative configuration file (JSON/YAML)**, allowing schools to adapt the app without writing code.

---

## 🛠️ Technical Stack

- **Front‑end:** Flutter (iOS, Android, Web, Desktop) – UI built dynamically from the configuration schema.  
- **Back‑end:** Cloud‑native microservices (Node.js / Go) behind a GraphQL gateway.  
- **Database:** PostgreSQL (relational data) + Redis (caching) + encrypted blob storage for documents.  
- **Security:** End‑to‑end encryption, fine‑grained RBAC, immutable audit logs, GDPR/FED‑RA/FERPA compliance.  
- **Deployment Options:** SaaS (hosted on Proton Cloud), Hybrid (cloud core + on‑prem data), or Fully on‑prem (Docker/Kubernetes bundle).  

---

## 🎨 Customisation Example

```yaml
dashboard:
  layout:
    - widget: announcements
      position: top
    - widget: timetable
      position: left
    - widget: grades_overview
      position: right
  theme:
    primaryColor: "#0047AB"
    logoUrl: "https://example.edu/logo.png"

timetable:
  periodLengthMinutes: 45
  weekPattern: ["Mon","Tue","Wed","Thu","Fri"]
  holidays:
    - start: "2026-04-01"
      end: "2026-04-10"
      label: "Spring Break"
