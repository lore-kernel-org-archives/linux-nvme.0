From: sunad.s@samsung.com (Sunad Bhandary S)
Date: Mon, 18 Apr 2016 12:00:51 +0000 (GMT)
Subject: Namespace removal deadlock in case of namespace detach command
Message-ID: <168786720.663071460980851178.JavaMail.weblogic@ep2mlwas04b>

On receipt of a namespace attribute changed AER, we acquire the namespace mutex lock before proceeding to scan and validate the namespace list.
In case of namespace detach/delete command, nvme_ns_remove function deadlocks trying to acquire the already held lock.

Thanks and Regards,
Sunad
