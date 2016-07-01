From: ed.cashin@acm.org (Ed Cashin)
Date: Thu, 30 Jun 2016 20:57:45 -0400
Subject: [PATCH v2 05/12] aoeblk: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-6-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630015953.6888-6-famz@redhat.com>
Message-ID: <5775C009.3010000@acm.org>

On 06/29/2016 09:59 PM, Fam Zheng wrote:
> It is documented that KOBJ_ADD should be generated after the object's
> attributes and children are ready.  We can achieve this with the new
> disk_gen_uevents interface.

Looks like an improvement, thanks!

-- 
   Ed
