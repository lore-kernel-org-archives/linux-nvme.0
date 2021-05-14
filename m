Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D09C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 10:45:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE04B61406
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 10:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE04B61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x+9/UCvtveUx60Ya3Fj2GPb+pFFCrcmP36ZsteWXY28=; b=KHvHzn6BZRXTjoBR3hc+Y3Xcp
	S9KF/JLxzTaCrY/VQeHsfMFMvaCIVsWhY5VDLLTAP8rsA2oXhY/ibfK8iFsZY1TNibQr9HeFsSYdn
	POz7GmlaJF7CiiO5cJQEhAZBTjjAUEytUsWLRqDv5IgvzN3i7lxhfwxNSKtrM+5xQYXZAo0srZNdi
	UoAMeyjU5L5Hktr8riCjdIcvwPNVD7rOj+DA5VDLBQRywk1fmhl6thqx8AJ9aU/GZn8xMe3UwTv6J
	1qAFwLjmRUbVaYz/SiwhYvEnUsTsEK+7iRYGFAAR2R/tP1tfzRGFJT5NJ2FdH7Swrj5UMG2JX4G+x
	ZuW0zyuJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhVJI-007oMf-6K; Fri, 14 May 2021 10:44:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhVJE-007oMN-Ul
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 10:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=NiLLB9DjtlRLw+/IuuhXXQWMt40mTCqzNCkrhFWzU+Y=; b=DbHNm+xTDnEdHczSAc8UldpN46
 zTeNsIDSIlKrHnEsN0sERsMrOBvLQeELivOwzpz2glGmQtKVcP3w4MI9op/Z6wscs71No/jfseXVv
 wfQ1eqthW0X2AopQwAp0YoN9nMwZvOS/LhGTf04SmJvR5iKS0eK5B3s3yWf57MEuNfgXrqlTbNWZC
 BrYD85vAgQvweqneT/QeYwxsAdUFdvvTSmK2GlBzlOQFgMDb9OwhHIqX7I+PSCKVROcIZDokk98UT
 IMHcyft4K8qRV4sZbQro1zGPKtGH+VNXuh/cQdUK+rCEs+eKsS9whub2MhaXd4IqYWe+fYoyG8yYq
 I6rg7PWg==;
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhVJ9-00BuSU-Pr
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 10:44:43 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210514104428epoutp04cd08b1d3d2b83a082f435b954233155e~_6PgrUCmx2377023770epoutp047
 for <linux-nvme@lists.infradead.org>; Fri, 14 May 2021 10:44:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210514104428epoutp04cd08b1d3d2b83a082f435b954233155e~_6PgrUCmx2377023770epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1620989068;
 bh=NiLLB9DjtlRLw+/IuuhXXQWMt40mTCqzNCkrhFWzU+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aa4cLFSTEg+6dXSe8dhko0KFp42VbwiYLXc4kCQBgUToxUilZLt8DcVYzI6AQQV+2
 ySiIcKzMyH+Phrt0NylFviC5LeF2Av4Hq/OqSNaAbfDntGyF+Ald2pzRSPc8r5qbku
 3OdNIJZ34gqtNJ13CPqej8RVGkCuxCd9FqiawQtE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210514104428epcas1p2137dce660926fb01549871c9f6e3597c~_6PgZ55Hd0555605556epcas1p2M;
 Fri, 14 May 2021 10:44:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4FhQBg1sGtz4x9Px; Fri, 14 May
 2021 10:44:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 64.D4.10258.B845E906; Fri, 14 May 2021 19:44:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20210514104426epcas1p3ee2f22f8e18c961118795c356e6a14ae~_6PfFHYjm1546315463epcas1p3A;
 Fri, 14 May 2021 10:44:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210514104426epsmtrp2b4b61e2a32c20e413f6f376b6f951881~_6PfEO0Pg1199011990epsmtrp2Q;
 Fri, 14 May 2021 10:44:26 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-57-609e548bcb48
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0E.13.08637.A845E906; Fri, 14 May 2021 19:44:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210514104426epsmtip2751bc9e19e43c18b0a2e5d6b85b92001~_6Pe0Wb0O2557925579epsmtip2T;
 Fri, 14 May 2021 10:44:26 +0000 (GMT)
From: Changheun Lee <nanich.lee@samsung.com>
To: alex_y_xu@yahoo.ca
Cc: gmazyland@gmail.com, bvanassche@acm.org, tytso@mit.edu, axboe@kernel.dk,
 bgoncalv@redhat.com, dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
Date: Fri, 14 May 2021 19:26:14 +0900
Message-Id: <20210514102614.3804-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <alpine.LRH.2.02.2105140544010.22439@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxT29j1eX2GwJ0K9NsbVN1kUBVpL8UrELJGZFyULCewPZQlU+gZs
 /bW+VmVmE8U6+RHGwDEpozWOsEgHTobjZwULjLIBiQFGqjBGwMG2CAymDkVYS0vGf9+55/vO
 Od+595JY8AghIrM0BlavUahowh//oXNPZERBsiVNMj4ZgOpGv+Uj29hnBGq5bwWobH4JQw9z
 nxPIPlvhh35sN/PRTVs3D03dMmPI/mAvKreMEmiw5SsCWasf8ZGjNJeHTIVLfDQyUEa8STGD
 Q8eZZvMYnxnsNzL1NXkE833VeabVlUMwF/u6MWbu7jDB9LX18JjF+h2Mw1GNJQacVB3KZBVK
 Vi9mNelaZZYmI44+npR6JFUeI5FGSA+iA7RYo1CzcXR8QmLE0SyV2w0tPq1QGd1HiQqOo6MO
 H9JrjQZWnKnlDHE0q1OqdFKJLpJTqDmjJiMyXauOlUok++VuZpoqs70kB+icQWcb7k775YDW
 gHwgICEVDe/duADygT8ZTDUBmLNk4nuDBQB/G633ZZ66M6WlvHXJyrNnmDdhB9A83++TLAL4
 Zdk87mER1D5Y9PgB4cEhlBAuWZdwDwmj7vOga7LLLx+Q5BbqBLSaKA8Hp8LgVUetnwcHUrGw
 tdMzh6fba3B5vBDzYAGVApunLuJezmbYWz61hjE3J/dOxdpEkBoiYcHqNeAVx8PilSbci7fA
 P3safEVFcHHWTngFBQDmXrYCb1AMYNV0tc+oDC4sLgLPpBi1B95qifIe74TNLyqBt3MQnH1S
 uGYGUoHwyuVgL2UX7Ls0jq33mq5t9lVkoOvShG+ndQAuz3bixUBs3mDIvMGQ+f/O1wFWA4Ss
 jlNnsJxUF73xkuvB2gsPR02g8vF8pAPwSOAAkMTokEDhqYq04EClIvsjVq9N1RtVLOcAcve6
 P8dEoela9xfRGFKl8v0ymQxFxxyIkcvorYEZR86lBVMZCgP7AcvqWP26jkcKRDm8CwfrskNF
 Tvr8Nr7tdMe221srZvCbM21Fh2sox76ql5PtjbWO31d0D+MXXifUe3vlE61hfR/bSxPej7E2
 ZSV1vvPTF98JjtWxA/ey4/IShM4/hsnR8PRfk6mUrrLVr8+0zuiHPn03KdN+paXj6txMlMCZ
 Z/rXETQ3r9sEtxfcYIY/kaVK3uoP8jtnO9Uzu7P42LUkdVfM7pLt11M2/6Ie8f/wPWejC7co
 hUdDxjrqhZKa5d4TFPcCf86F7bA+eRtV/dX1Uuy08S1k6NOFuKKBv++8Yik5s/Bz98lHytXK
 N/zLRSbUtmm3iDCHRb26kjyRHLt8tjH5n9uk4ZtdhRZTgyubxrlMhTQc03OK/wBoL72TagQA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXrcrZF6CwdOLKhbr7qxht1h9t5/N
 YtfF+YwW0z78ZLa43fyLzWLvu9msFsf2z2K3WLn6KJPFk/WzmC323tK2mDnvDpvF5V1z2Czm
 L3vKbnFocjOTRWvPT3aL6+emsTkIeFy+4u2xc9Zddo/LZ0s9Nq3qZPPYvKTeY/fNBjaPpjNH
 mT3e77vK5nFmz3Emj8+b5DwOHVrGHMAdxWWTkpqTWZZapG+XwJWxf1IDY8EJvoot+56zNjDu
 5u5i5OSQEDCR+Pf9OzOILSSwm1HizTxpiLiUxPETb1m7GDmAbGGJw4eLuxi5gEo+MkpMmn6K
 FaSGTUBHou/tLTYQW0RATOLn/J8sIEXMAk+ZJJoWnmIGaRYWCJdouu4EUsMioCox5dBasF5e
 ASuJ3Ydb2SF2yUv8ud8DdgOnQLTEzidNLBD3REn8PXSFGaJeUOLkzCdgcWag+uats5knMArM
 QpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcIRpae5g3L7qg94hRiYO
 xkOMEhzMSiK8YkmzE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
 ZeLglGpgiqzTW58446l/zvKD8xKXb66vuqC84LR5maFqQnh7fvzVjUePP/R+siYjSonNZ2a2
 o71BRWvtvv33F056ddPfbcVtaZH+nwG/JguVeRqUXv8prF33rD3px1KNg97F7xcV8sf6XXmp
 NcHr95YTaucUyrq3TbFIWeb+6uKJfNOJdoum/b7A9XLWFrfHXa/uTY76FCF5W/eD9XI1vdZ5
 y7gYE1ZybXu/ovZgzC5xQWWjRSGJuiGGZtMzQtPSS04XBnfstXjGoZtb8/6rjyTf4mVKHver
 /fct2h+3Wu3L4QnzTmq1357Z9HB50BvtgPod05qWPlJbf+3rVmMlxpnm9/R3sBqeeXrHed8F
 Q5103m8bVZVYijMSDbWYi4oTAV1pZqQfAwAA
X-CMS-MailID: 20210514104426epcas1p3ee2f22f8e18c961118795c356e6a14ae
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210514104426epcas1p3ee2f22f8e18c961118795c356e6a14ae
References: <alpine.LRH.2.02.2105140544010.22439@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20210514104426epcas1p3ee2f22f8e18c961118795c356e6a14ae@epcas1p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_034440_190308_DDD61656 
X-CRM114-Status: GOOD (  31.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> > On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
> >>
> >> Problem might be casued by exhausting of memory. And memory exhausting
> >> would be caused by setting of small bio_max_size. Actually it was not
> >> reproduced in my VM environment at first. But, I reproduced same problem
> >> when bio_max_size is set with 8KB forced. Too many bio allocation would
> >> be occurred by setting of 8KB bio_max_size.
> > 
> > Hmm... I'm not sure how to align your diagnosis with the symptoms in
> > the bug report.  If we were limited by memory, that should slow down
> > the I/O, but we should still be making forward progress, no?  And a
> > forced reboot should not result in data corruption, unless maybe there
> 
> If you use data=writeback, data writes and journal writes are not 
> synchronized. So, it may be possible that a journal write made it through, 
> a data write didn't - the end result would be a file containing random 
> contents that was on the disk.
> 
> Changheun - do you use data=writeback? Did the corruption happen only in 
> newly created files? Or did it corrupt existing files?

Actually I didn't reproduced data corruption. I only reproduced hang during
making ext4 filesystem. Alex, could you check it?

> 
> > was a missing check for a failed memory allocation, causing data to be
> > written to the wrong location, a missing error check leading to the
> > block or file system layer not noticing that a write had failed
> > (although again, memory exhaustion should not lead to failed writes;
> > it might slow us down, sure, but if writes are being failed, something
> > is Badly Going Wrong --- things like writes to the swap device or
> > writes by the page cleaner must succeed, or else Things Would Go Bad
> > In A Hurry).
> 
> Mikulas

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
