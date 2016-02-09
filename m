From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Feb 2016 22:55:49 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB199E172F7B186281D1C7179E0D60@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203144123.GB23910@localhost.localdomain>
 <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203163808.GC23910@localhost.localdomain>
 <BJXPR01MB19916231021454BD8731EBDE0D30@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160208150132.GA25111@localhost.localdomain>
 <BJXPR01MB199E172F7B186281D1C7179E0D60@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160209225548.GA32064@localhost.localdomain>

On Tue, Feb 09, 2016@11:22:04AM +0000, Wenbo Wang wrote:
> In most cases, rcu read lock is just a preempt_disable, which is what get_cpu does. I don't see any risk.

Yes, many rcu_read_lock cases expand similarly to get_cpu. What about
the other cases?

FWIW, I don't think we'll hit the problem with the proposed rcu sync.
Heck, we don't even have a synchronize today and we don't hit the
theoretical problem.
