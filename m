Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA78C2BA1B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:In-Reply-To:References:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zK6bnzWagbOYvwm2T1Ws8TUZ1HfPduLrKfigoLYCs9k=; b=oyL+c21Ltms6B2bBU+iKE43Gk5
	uIfIqjcAwQRCrBasA0Wnxsv8blRK3R6712EN+hxEV+JfclvevbeiAFF1x0pDDqbuBazRuHPBgWBdZ
	c3sDoXqvtC2tXjOWlmyRV8xRiyITdPfymdeHRBP9vw9/Ap/E9+2o+mURS9EUr2+1BUmnRn7Ff+Q3R
	af6xxZXt5bQ7TOW+sUwaEeJFmZmcFiXWMNfdExZ4VQqDNVSc92lOqeqW+wM8xkWcDiqnROG4LQfeL
	rNSUdkTj3cHWB1gSq+tJ05tdgyooL/ugJ0G97Wj/ABaMb9y5ua2Vv2A7pfxmuNWnOxDWUhU/rNnyF
	sD3WqdzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQqW-00000009FeQ-0uhF;
	Wed, 12 Mar 2025 18:30:24 +0000
Received: from mout.perfora.net ([74.208.4.194])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQpC-00000009FSz-3GPv
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 18:29:04 +0000
Received: from jimw8 ([98.97.29.152]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MzQ0y-1sx0on04W0-00quET; Wed, 12 Mar
 2025 19:28:53 +0100
From: "James R. Bergsten" <jim@thebergstens.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
	"'Matthew Wilcox'" <willy@infradead.org>
Cc: "'Hannes Reinecke'" <hare@suse.de>,
	"'Vlastimil Babka'" <vbabka@suse.cz>,
	"'Hannes Reinecke'" <hare@suse.com>,
	"'Boris Pismenny'" <borisp@nvidia.com>,
	"'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Sagi Grimberg'" <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>,
	<linux-mm@kvack.org>,
	"'Harry Yoo'" <harry.yoo@oracle.com>,
	<netdev@vger.kernel.org>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org> <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com> <Z8cv9VKka2KBnBKV@casper.infradead.org> <Z8dA8l1NR-xmFWyq@casper.infradead.org> <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de> <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz> <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com> <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz> <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de> <Z8iTzPRieLB7Ee-9@casper.infradead.org> <Z9Gjnl5tfpY7xgea@infradead.org>
In-Reply-To: <Z9Gjnl5tfpY7xgea@infradead.org>
Subject: RE: Networking people smell funny and make poor life choices
Date: Wed, 12 Mar 2025 11:28:50 -0700
Message-ID: <052801db937c$9bbf12a0$d33d37e0$@thebergstens.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
thread-index: AQI2rUWeLygajSlNpi7nOHx73cja5QH+C8IvAd0w/QUCBlqL4QM6XMyIAn2avhICzfEg4wKgxvSGAjQyxh8Ce7EXuQFi0EC+sgC+5wA=
Content-Language: en-us
X-Provags-ID: V03:K1:dcMVW0pDz5E1JPOonU9qWaZvIh+IDuHLVFneVIlFdETc33dVveN
 co1twA9Ugo5PZKV/k+r4WR/2ZVc4wvMXZO6XGkeFi3qR8cm4kSN7Er9rDAQQn2OpKfUQekK
 1XVIeA/RxxBoaSPZ77QBYg2hW+h8FjKLg4otGWhoiv6MVVBL+FK7MuMf8u/91uNgJDY+vS8
 efdi4I1cmyyDRPbTMS6NQ==
UI-OutboundReport: notjunk:1;M01:P0:0C6G/a5TfTo=;EQqAowdRCwMZrivTSoBJYtVAB70
 MohO5kz6kUnw5GSDAM/CFxMD1LsnEUtWNbdiLuCoG6HwUKs71eYLPumEwg7vttAekfyqxsvmn
 yoyCXakGb8r2kImoHPCPH5BO4xl+NgwLFE1gC3Cl/DAx0vJhzNIoOQQKEWiLAw5pGkzLbSI2k
 Fq1aDkD7QOrIYo7jQeaFpjGW+5heRtbNQJSGTlzZLmnlLlOf55cyaNWdGjLOJafmaNpq7yB5a
 DOJnpuW6Mb1fZB3jxZL726qcb1r/KEa7PY/HoboN1qWhCtx9YX99E6HPXB0yqq6bttx1g0BMw
 KAfp3C97/s9f3m32aEHw8mY7te7l4uFSxsg3GN5KwmNhQVsN9HqOVHqJBxJAIf/KN9dhJIQgH
 I0AehCPc9QFzGessG6jBIjrluBIOTX8RsjAlUUKTZzMCER+N3jXHtkDd3ahIRWS2YagPjNkMt
 zwGuF2rVA2/2n2h/1LPzs9gUPWnYWh1fDFD/BAsROwdtCkDqzpxvUT00uZ4k4VbCiZ+wnMpGi
 HX6Pz5h1xmJRmMBnEfR/G8V+KTtZQzthdxOj+nv6Ss0/j5arjKb+oew/UbrB4gamF+rvBuHG8
 kAh3HPBuy6aYOWTfFFeIS8gOnRkzbsZraudh71vqJs5HWzPegzX8Nc8+6+Uw2WOdHXWZICtCV
 eAOYkhvsQcq2k/O226/TBfcJTQqw9G8BwBh3YrC0ehi9aJm4GqhJWsNC7VIug65nKKWL16HYF
 XY8FDND5BHs3HH64jKaJNak+6uYMdc3BMLxmNHt7nRG3laA1WLNCdKxk2SuDRqY9EalOvX5s+
 X6Q3u2IfAK41xywS4dedXzALf109cVCy5JKvp8ZQeurBlUZ+tTOqcxb208N2D8a8ATPXNEIC6
 demkZsPEOZ8+3au0HVs/+EERrBUqHaUNmwoDGbsibhM9i1EnUavo/alh6fdxiG4vSMBi9V8zc
 Tq0dmAIaXlAh9ecICjV8z1A7dILM5mOAAAK9GwWkA4Y+QfQfVEZtaBP8vnk9w+co1ZTjhQkyD
 ulSc6wutq/im9ZUiTcPEkBC02RLDaDg4buqO3nqUosSQdL//d9HUNVywgCYh4c0QrHeVIH8yY
 MhqEU3pB4NtY5G6eHPLJD/lMMbWDhqQMx55ikTf0HxnH08fXQKoCb41ylk3tp/JI2Q5U30q+Y
 yRC8TKoPslhu5WDIA3w0TBpb5iWpVEmGsVSgcAAbIOCwTbWh2tWvQkyt6NCOxmlF0UWI3cswI
 +pnlU1UC3HMIRENDatsfARyqIrHmOc2y9og83Bmc0/v0zHSM389u55phBqoyMoQH0cuIcuoRZ
 bx2mMKpSUEQa3RF2uJt8iaPSrAhHCIgZk2GeoKEzqde7J/sSgNUUK4uLyw9dSlrOw/HGuowvr
 4wpFqVb+jK1dzpRg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_112902_881040_894688EE 
X-CRM114-Status: GOOD (  17.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

OK another "unnecessary" old-timer storage/network story/disruption to =
your otherwise relevant discussions (thank the subject line). If you're =
too busy, just don't read it. =F0=9F=98=8A

Around 1985, Gene Amdahl founded a company called Andor. Its original =
purpose (as was with everything Gene did) was to build the smallest =
plug-compatible mainframe.  When it was designed, someone noted it had =
no physical room for the humongous "Bus and Tag" cables needed for =
peripherals, so Gene raised a bit more money and started a storage =
project too.

When the Loma Prieta earthquake happened in 1989, PG&E, the local =
utility, lost the datacenter containing all of the information needed to =
repair their utilities, so the service people had to do this from =
memory.  The Public Utilities Commission didn't find this terribly =
funny, so they said PG&E had to create a second datacenter out of the =
area immediately and have backups there within about 24 hours, shorter =
as time went on.  So, they shut down the primary site every night, =
dumped to tape, then drove it up to Sacramento where these were =
restored.  They named this CTAM for "Chevy Truck Access Method."

Somehow Gene and friends heard about this and, as they already had a =
processor, device simulation and devices, if they added some sort of =
networking interface, they could have a local unit and a remote unit =
doing this backup, eliminating the truck.  BTW the "front end" storage =
group all came from Memorex.  The "back end" group mostly from Amdahl.

This actually (somewhat) worked, and a couple of units were installed in =
beta sites.  Sadly, Gene ran out of money (or at least didn't accept the =
terms offered) and buggered off to start yet another mainframe company =
which never shipped anything.

I was the last Engineering VP at Andor, so when it folded, I grabbed a =
few of the people and started a similar company but for the open systems =
market instead.  We named it "Ark" at my wife's suggestion as was like =
Noah's Ark - "disaster recovery" and "two of everything."  We mostly =
bootstrapped, did ship product, and were acquired by LSI Logic who were =
getting beaten around the head as EMC had a remote solution, but LSI =
didn't. I got about a dozen US Patents Issued and enough money to =
finally buy a house in Silicon Valley.

Our (SCSI-based) device had front end ports for the host(s), back-end =
ones for the devices, and side ones for the networking.  Lots of =
features, some you folks are only doing recently.  Looked like devices =
to hosts, hosts to devices.

Anyway, the point of all of this is that when we sold it to customers, =
the storage people looked at the network ports with confusion and dismay =
(some hadn't even ordered the network lines and caused months of delay), =
while the network people looked at the device ports as if they were full =
of Tasmanian devils.

Turned out, both network and storage expertise were very rare =
commodities.  This was largely why most iSCSI startups failed, they =
either did a storage product or a networking product. We pilled this off =
because I am stupid but stubborn and wrote the RTOS myself (Linux was in =
its infancy and the other RTOS's sucked).  Seemed a good idea at the =
time.  Have white papers online if anybody is interested.

So, networking people may smell funny, but to them storage people come =
from another galaxy.  Working in this industry at all could be =
considered a poor life choice but that's for another time.

Sorry. You can go back to work now.
Jim B

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of =
Christoph Hellwig
Sent: Wednesday, March 12, 2025 8:09 AM
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>; Vlastimil Babka <vbabka@suse.cz>; =
Hannes Reinecke <hare@suse.com>; Boris Pismenny <borisp@nvidia.com>; =
John Fastabend <john.fastabend@gmail.com>; Jakub Kicinski =
<kuba@kernel.org>; Sagi Grimberg <sagi@grimberg.me>; =
linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; =
linux-mm@kvack.org; Harry Yoo <harry.yoo@oracle.com>; =
netdev@vger.kernel.org
Subject: Re: Networking people smell funny and make poor life choices

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON=20
> PAGES.

The block layer never took references on pages.  The direct I/O helpers =
that just happened to set in block/ did hold references and abused some =
field in the bio for it (and still do for the pinning), but the =
reference was (and the pin now is) owned by the submitter.

The block layer model has always been that the submitter needs to ensure =
memory stays allocated until the I/O has completed.  Which IMHO is the =
only sane model for dealing with memory lifetimes vs I/O, and something =
networking absolutely should follow.




