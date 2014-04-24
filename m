From: ebrahimh@supermicro.com (Ebrahim Hashemi)
Date: Thu, 24 Apr 2014 02:50:21 -0700
Subject: Cmd - comp write 
In-Reply-To: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
References: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
Message-ID: <09F85D53A2F0C547BF5E05E214DB880A3B8A461EC7@MAIL5.supermicro.com>

I think it could be used for that purpose, but it can also be used like a "semaphore" or "test and set". For example,  alleviating the need for SCSI persistent reservation.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Learner
Sent: Wednesday, April 23, 2014 8:38 PM
To: linux-nvme
Subject: Cmd - comp write 

Hello

How frequently is Fused command - compare-write used? 
Is it for avoiding writes for SSDs if thee is no change? Ie read and compare the block to be written and don't write if there is no change.. 

Thanks 

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
