From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Fri, 12 Aug 2016 14:40:32 -0300
Subject: nvme_change_ctrl_state() bug?
In-Reply-To: <258e01d1f4be$ec094890$c41bd9b0$@opengridcomputing.com> (Steve
 Wise's message of "Fri, 12 Aug 2016 12:28:20 -0500")
References: <258e01d1f4be$ec094890$c41bd9b0$@opengridcomputing.com>
Message-ID: <878tw1sx67.fsf@linux.vnet.ibm.com>

"Steve Wise" <swise at opengridcomputing.com> writes:

> Shouldn't the assigning of the state be inside the lock?  

Yes, I sent a patch for it, but it hasn't been accepted yet.

http://lists.infradead.org/pipermail/linux-nvme/2016-July/005551.html

-- 
Gabriel Krisman Bertazi
