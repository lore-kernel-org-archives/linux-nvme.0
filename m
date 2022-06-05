Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E6BC43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:
	From:To:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n2mpQHghi5vFybdULPdyNsNX2motmZHZDTc04ToiVNQ=; b=SbvhoXzRijsbkn
	JDdVo0I1q5pf8mjQPv9ejZh3teyHYL5+nwrS/upNCdQdTz5ypL9mcqQK9lwWitKkJ9b2U6uX2UY2+
	4czTXJifeiqbNZy6Aa1miDZDssR+j0lSfPtyMyweHYtvXgIZNUKI2IPJcf9EHLYF38zwyFbWjUQXe
	fW1H3k/OBaLMX/yXjAtlo4NQyDDm7oLxe/pxnfWVCoqpjVWT89Px6VMcWJcc5Fupr6gMBeJP1gml3
	zug1huLdfIAGXacE0KEQcVlofXBhitdgkUAHQnlD5yPOMiI2RIml2gltnrBsZxdYmQR5xzqf1EP/t
	mfh0/33kEkITnWR+5sTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEHZ-001g8M-0O; Mon, 06 Jun 2022 15:04:41 +0000
Received: from mail-4323.proton.ch ([185.70.43.23])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nxfX1-00CtIs-CO
	for linux-nvme@lists.infradead.org; Sun, 05 Jun 2022 01:58:22 +0000
Date: Sun, 05 Jun 2022 01:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimaker.at;
	s=protonmail2; t=1654394294; x=1654653494;
	bh=n2mpQHghi5vFybdULPdyNsNX2motmZHZDTc04ToiVNQ=;
	h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
	b=SWWgnWmMyTQQPgAQAQoUA5dLhLXW8cbKwQ7zTwSUXZ9FMLFNIEygT8ftfiU3wps+L
	 umIVpsWnKvzD4VL158Ij4s7wGbfGSKZYHGVMivdoM2dUx3EWFiobKApr3Nn2ZL23oD
	 1nIkMfr9H0ir7VeNOvKxvtKDB/UKmbx3nNCxtVOaAgbKsRQx5brGISbVPOBjm6FHGR
	 MZ+2qYR5MKI7VvDQHJ5Ld+nGIvyuclxrTYA+RMIlGoHEggim4r8Y34Ch61YK8Vex7r
	 DcWBdHgvwxjklPY6FbW4O0jyppqWq7WfpgQBHdnq0IpeunuOPJQ0qIc/Z13Kc7Mf25
	 JKou/mt7MoZUQ==
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
From: Stefan <stefan@pimaker.at>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at>
Feedback-ID: 6415277:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220604_185820_855953_CD266CB9 
X-CRM114-Status: GOOD (  14.36  )
X-Mailman-Approved-At: Mon, 06 Jun 2022 08:04:37 -0700
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
Reply-To: Stefan <stefan@pimaker.at>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/24/22 20:28, Christoph Hellwig wrote:
> Add a check to verify that the unique identifiers are unique globally
> in addition to the existing check that verifies that they are unique
> inside a single subsystem.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Hi list!

(not following nvme-dev, sorry if reported before)

Ran into a boot failure on my workstation today and I traced it to this
commit, reverting it on v5.18.1 makes it work. Quad-nvme boot raid.

I saw some follow-ups adding quirks, so I added NVME_QUIRK_BOGUS_NID to my
drives (1cc1:5350 for reference) and that worked too - if this is ok for an
actual patch let me know.

Prints error "globally duplicate IDs for nsid 1". Symptom is one drive
(appears to be random every boot?) not showing up in /dev/disk/by-id, other=
 3
are there and accessible. Happens 100%, no chance at mapping my raid.

System info:

# nvme list

Node          Generic     SN            Model           Namespace Usage    =
                 Format        FW Rev
------------- ----------- ------------- --------------- --------- ---------=
---------------- ------------- --------
/dev/nvme3n1  /dev/ng3n1  PJ5220001302  XPG GAMMIX S50  1           1.00  T=
B /   1.00  TB   4 KiB +  0 B  EGFM11.2
/dev/nvme2n1  /dev/ng2n1  PJ5220001308  XPG GAMMIX S50  1           1.00  T=
B /   1.00  TB   4 KiB +  0 B  EGFM11.2
/dev/nvme1n1  /dev/ng1n1  PJ3820001439  XPG GAMMIX S50  1           1.00  T=
B /   1.00  TB   4 KiB +  0 B  EGFM11.2
/dev/nvme0n1  /dev/ng0n1  PJ3820001437  XPG GAMMIX S50  1           1.00  T=
B /   1.00  TB   4 KiB +  0 B  EGFM11.2

# cat /sys/class/nvme/nvmeX/nvmeXn1/nsid
1

Out of curiosity, I tried printk'ing the values being compared here, and it=
's
the same for all drives:

   uuid: 00000000-0000-0000-0000-000000000000
  nguid: empty?
  eui64: random (?), but always same on all drives


Open to provide more info,
Thanks,

~ Stefan


