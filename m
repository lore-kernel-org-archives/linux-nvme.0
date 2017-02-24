From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:30 -0800
Subject: nvme-cli: JSON format Memory leak fixes. 
Message-ID: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>


Hi,

Following patch series provides multiple memory leak fixes
for nvme-cli commands. Memory leaks were found especially
when using JSON format for following list of commands:-
 1. id-ctrl.
 2. id-ns.
 3. error-log.
 4. resv-report.
 5. smart-log.
 6. fw-log.
 7. json_add_smart_log().

Regards,
-Chaitanya
