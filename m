From: ed.cashin@acm.org (Ed Cashin)
Date: Wed, 17 Aug 2016 21:09:37 -0400
Subject: [PATCH 06/15] genhd: Add return code to device_add_disk
In-Reply-To: <20160817091422.GE19326@al.usersys.redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-7-git-send-email-famz@redhat.com>
 <20160817104914.37087cb3.cornelia.huck@de.ibm.com>
 <20160817084823.GB19326@al.usersys.redhat.com>
 <20160817110645.45370f57.cornelia.huck@de.ibm.com>
 <20160817091422.GE19326@al.usersys.redhat.com>
Message-ID: <57B50AD1.6010403@acm.org>

On 08/17/2016 05:14 AM, Fam Zheng wrote:
...
> Of course, the plan is to write patches on top. I'm not cleaning up anything
> here because I'm concerned callers may double free (and I didn't look hard into
> that).

Aside from Huck's concerns, the changes looked OK from aoe's perspective.

-- 
   Ed
