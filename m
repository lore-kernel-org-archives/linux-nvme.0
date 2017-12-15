From: Berck.Nash@wdc.com (Berck Nash)
Date: Fri, 15 Dec 2017 18:46:48 +0000
Subject: Fabrics Bug: keep alive timer re-initialized when active
Message-ID: <MWHPR04MB09434A9403F6CD4742D39C94820B0@MWHPR04MB0943.namprd04.prod.outlook.com>

During fabric cable pulls, sometimes the keep alive timer gets 
re-initialized while it's already active.  It appears to be a race as it 
doesn't happen every time, but can be reproduced fairly consistently 
with a dozen or cable pulls.  Without object debugging enabled, the 
resulting crash is a pretty opaque dereference of a poisoned object. 
See attached for the ODEBUG output.

We're seeing this on 4.12, but I couldn't find any reference to it being 
fixed later.

Berck Nash
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: restart_keepalive
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171215/14af1b5b/attachment.ksh>
