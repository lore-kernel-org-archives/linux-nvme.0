From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 24 Jul 2015 11:26:58 -0400
Subject: [PATCH 4/5] block: Export integrity data interval size in sysfs
In-Reply-To: <55AF8064.4040409@dev.mellanox.co.il> (Sagi Grimberg's message of
 "Wed, 22 Jul 2015 14:37:08 +0300")
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-5-git-send-email-martin.petersen@oracle.com>
 <55AF8064.4040409@dev.mellanox.co.il>
Message-ID: <yq1mvyly3st.fsf@sermon.lab.mkp.net>

>>>>> "Sagi" == Sagi Grimberg <sagig at dev.mellanox.co.il> writes:

>> +What: /sys/block/<disk>/integrity/data_interval_bytes

Sagi> I wander if pi_interval is not a more suitable name...

I have always found the SBC notion of "protection information interval"
a bit confusing. The interval describes the protected data, not the
protection information.

I am OK with protection_interval_bytes too. But I do think that having
data in there makes things clearer.

-- 
Martin K. Petersen	Oracle Linux Engineering
