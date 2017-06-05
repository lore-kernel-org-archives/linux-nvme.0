From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Mon, 5 Jun 2017 11:47:39 +0200 (CEST)
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <2015307566.53586286.1495553554276.JavaMail.zimbra@kalray.eu>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <20170522185127.GA27542@infradead.org>
 <2015307566.53586286.1495553554276.JavaMail.zimbra@kalray.eu>
Message-ID: <1547490771.73884959.1496656059974.JavaMail.zimbra@kalray.eu>

>> I've hand applies this once with a few formatting tweaks now that
>> I got the ACK from Sagi.  ?'d love to see if someone could figure
>> out how we could move the improved atomic + ilog version into the
>> rdma core somehow.
> 
> I'll submit the atomic+ilog version in nvme next week. I have no
> access to the test systems this week.
> 

I've just posted the new version, with changed title as the v2 is
merged. The new thread name is:
[PATCH] nvme-rdma: remove race conditions from IB signalling

Marta
