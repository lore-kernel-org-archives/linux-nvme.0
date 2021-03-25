Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C1C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 17:07:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9CD61A16
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 17:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9CD61A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=6jjVCQfztZCGnA78offmcTZZweSF+mBxfkFqZ1gi/y0=; b=dGOY1amrTcNksGPUgOxSNEk7H
	73oiOYksiI3MPV3hZg01Z7QTbo8pUQ934QtAMI0ZChWzYEFlU8Q77eCGFHY0EPnY5yxXHVi2fXKbg
	Px0+DmygskcG0rPhytNnIzm3GzGECrrXlB9d4U0/iAtURq+e2FM0jfFA/AnwdS34/9oRbA57duZJ0
	53o1T2cYRZ1YUnRhO5nRUqmA/RLJXT4hjwCl9Vd4q2QSQrSiZLhHuXl5SXV63c3upza0f6rsFFomH
	vE8VrX9ed/VA6FaN2zRgEzJKCMlD8WrevIVsi8b2qFv6LfLUF/cQ0algFkoDg8DSXIDW+17C8Ihs1
	/yYtrTjUw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPTRy-001sRj-Mi; Thu, 25 Mar 2021 17:07:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPTRp-001sQO-KW
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 17:07:13 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210325170701epoutp0274cdbf11d23f099c99096c8fef93f666~vpNPhnHHD2414224142epoutp02S
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 17:07:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210325170701epoutp0274cdbf11d23f099c99096c8fef93f666~vpNPhnHHD2414224142epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1616692021;
 bh=xu/UUcd3MT+WNCVxK+2uk8ZyZ2u1HmSvztuoUAsA7Ww=;
 h=From:To:Cc:Subject:Date:References:From;
 b=vIcVYKpyNXAqjs4DdGK+E8lqnNEwSbUyqn2Wz9sISuw3cdi1bJhaYkN4MhfFeLVLl
 4wq33WebnkzLBrEjIF74QPeFD6cvH4Cl7TGcZaMkgwMoPro4xhtdUm5sXWRIeplZoE
 TodEErkuG2xtqNk6kPpqd+b2FJABlzcy0xshETXg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210325170700epcas5p459a1d7000a5c98f491bd3b9d0eb79fd5~vpNO54F-h0346503465epcas5p4S;
 Thu, 25 Mar 2021 17:07:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 69.C0.41008.433CC506; Fri, 26 Mar 2021 02:07:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210325170659epcas5p314b54d01c60189f899f67aaeb9d87a13~vpNOK4fJX1325713257epcas5p3t;
 Thu, 25 Mar 2021 17:06:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210325170659epsmtrp2c51f4d7730cb8b670e07f0bba3233e96~vpNOKGihc0326303263epsmtrp2Y;
 Thu, 25 Mar 2021 17:06:59 +0000 (GMT)
X-AuditID: b6c32a4b-64bff7000001a030-0e-605cc33433b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 FF.B2.08745.333CC506; Fri, 26 Mar 2021 02:06:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210325170657epsmtip29efa4d0541805537c21bf72339d00007~vpNMe9pmb2811028110epsmtip2o;
 Thu, 25 Mar 2021 17:06:57 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH v4 0/2] Async nvme passthrough via io_uring 
Date: Thu, 25 Mar 2021 22:35:38 +0530
Message-Id: <20210325170540.59619-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7bCmuq7J4ZgEg4f7RC2aJvxltlh9t5/N
 Ytbt1ywWK1cfZbJ413qOxeLxnc/sFkf/v2WzmHToGqPF/GVP2S22/Z7PbHFlyiJmi9c/TrI5
 8HhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejxeZOcR/uBbqYA9igum5TUnMyy1CJ9uwSujL33
 VjIXLOCt6LhxkbGBsZG7i5GDQ0LARKLxCH8XIxeHkMBuRomHa9axQzifGCUOvGuHcj4zSjQs
 u8rcxcgJ1tF18DRUYhejROPcfha4qi2btrGDzGUT0JS4MLkUpEFEIEBi18HPTCA2s8BRRolH
 K6tBbGEBB4lfTQfBhrIIqErM6vrICGLzClhI9L1YxwixTF5i5qXv7BBxQYmTM5+wQMyRl2je
 OpsZZK+EQCOHxKTOfWwQDS4Sb+8cYYKwhSVeHd/CDmFLSXx+txeqplji152jUM0djBLXG2ay
 QCTsJS7u+csE8gAz0APrd+lDLOOT6P39hAkSXrwSHW1CENWKEvcmPWWFsMUlHs5YwgpR4iGx
 rVsCJCwkECvx8e1V5gmMcrOQfDALyQezEHYtYGRexSiZWlCcm55abFpgnJdarlecmFtcmpeu
 l5yfu4kRnH60vHcwPnrwQe8QIxMH4yFGCQ5mJRHeJN+YBCHelMTKqtSi/Pii0pzU4kOM0hws
 SuK8OwwexAsJpCeWpGanphakFsFkmTg4pRqY4pSPV9x2i6sPNvz2hXGCWkvWY4FQv56gDLa8
 CeK/knQP267/vie00WT2v9aLNrM0FELvqnzb+fGKwv30qOaUKf8+iRr6LqtfJ7Hm6gxp2b1i
 y/kr7PW32rI6s/Gkv7xoMenV6fUZHL7hfn8zTz5c9eDokYnyG//+eMSe5Hx+KsOmuX4zvSQL
 m7nOxO9yuRQwVefKsdNXs8r/V1+9sKtD+cTl1g5rzaJuftevmzcunPjEONakKvL82suzV83y
 OWZ5e8ehA5Ef703amlp7L7ZVqEKq4f+xY74yKr5THm2JMwqsO/pYz799qXdL15872fJyOZrS
 X9J8T+lyCUj9f6oguP2SlFHi6got1e3HA+TvKrEUZyQaajEXFScCAFYSRxyuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK7x4ZgEg+ZbqhZNE/4yW6y+289m
 Mev2axaLlauPMlm8az3HYvH4zmd2i6P/37JZTDp0jdFi/rKn7Bbbfs9ntrgyZRGzxesfJ9kc
 eDwuny312LSqk81j85J6j903G9g8+rasYvT4vEnOo/1AN1MAexSXTUpqTmZZapG+XQJXxt57
 K5kLFvBWdNy4yNjA2MjdxcjJISFgItF18DR7FyMXh5DADkaJOzvOs0EkxCWar/1gh7CFJVb+
 ew5V9JFR4tvsiaxdjBwcbAKaEhcml4LUiAiESHTN28YEUsMscJZRYvnjdkaQhLCAg8SvpoPM
 IDaLgKrErK6PYHFeAQuJvhfrGCEWyEvMvPSdHSIuKHFy5hMWEJsZKN68dTbzBEa+WUhSs5Ck
 FjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA50La0djHtWfdA7xMjEwXiIUYKD
 WUmEN8k3JkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkG
 pto7zscTVd5maK9eWrkwRsx+3xnvstMbipJV4me1qEwRWMVud1B4rfAUmw9HDlybKlv7Tagz
 4fmTRLc5/95aFUiffJzPrhA6q/FanLmI8vTEGaxRJ8+GX5lutZix11iHc9OjDoOO05lFRSp/
 At7tuRnQp97gULIk6UXaEs2Xxzz4GvTKz1uxTm8+rXct5a85f+Gxg6aHD6/YvrG2vqzh0v/U
 Ju28bzMtos7OftEl2H8kT+dBcFDe3junxFs3BzVaXuP/r7Fe4FWg34+Yd9I+vXqrn56ZMevX
 z8wYR+tn0y22T1Nf8Z3vWfuLzLcb5TJdnBNi5rJ9kn3SOTOjOmj+HfOXcz53NFS/EX+s/5b9
 jhJLcUaioRZzUXEiAHm1EyvjAgAA
X-CMS-MailID: 20210325170659epcas5p314b54d01c60189f899f67aaeb9d87a13
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210325170659epcas5p314b54d01c60189f899f67aaeb9d87a13
References: <CGME20210325170659epcas5p314b54d01c60189f899f67aaeb9d87a13@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_170706_843493_5B100C7D 
X-CRM114-Status: GOOD (  11.57  )
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

This series adds async passthrough capability for nvme block-dev over
io_uring.
The patches are on top of Jens uring-cmd series:
https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/
https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v4
The tree contains nvme-5.13 updates (pdu-enhancement patches of Keith)
as well.

Application is expected to allocate passthrough command structure, set
it up traditionally, and pass its address via
"block_uring_cmd->unused2[0]" field.
On completion, CQE is posted with completion-status after any ioctl
specific buffer/field update.

Tests are done by transforming fio io_uring read/write into
passthrough:
https://github.com/joshkan/fio/tree/uring_cmd_nvme_v4

Changes from v3:
1. Moved to v4 branch of Jens, adapted to interface changes
2. Extended support for NVME_IOCTL_IO_CMD64
3. Applied nvme feedback - hch, Keith
4. Appiled io_uring feedback - Jens, Stefan

Changes from v2:
1. Rebase against latest uring-cmd branch of Jens
2. Remove per-io nvme_command allocation
3. Disallow passthrough commands with non-zero command effects

Change from v1:
1. Rewire the work on top of Jens uring-cmd interface
2. Support only passthrough, and not other nvme ioctls

Kanchan Joshi (2):
  io_uring: add helpers for io_uring_cmd completion in submitter-task.
  nvme: wire up support for async passthrough

 drivers/nvme/host/core.c | 194 +++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |   3 +
 drivers/nvme/host/pci.c  |   1 +
 fs/io_uring.c            |  23 +++++
 include/linux/io_uring.h |  12 +++
 5 files changed, 206 insertions(+), 27 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
