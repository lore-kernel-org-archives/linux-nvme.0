Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F4CA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hm2agGAshuZsugLZ0pQzuhSejxyf1vg4VI5sjJjTHIk=; b=IUITOeF1PIu6H/69LolzvZXyT5
	cZkCygNuqfEOD9dEr3YiQSwoqeEvHIC8cGlAzZuiaakRNA79x0X3KwME+yvWDSPcgx7RXhcVrAQ8l
	y9uWpJMYC9JkkaHbZlYgpXV78sjbBukTzkJx7woRkeBnYed9pnO/YFcakcdo33GX47IhQGr93LnTA
	Wnvk+wDWL+VCoAkxTGMBg3kfr0UnXVrpkiTYmYLwa6/Ge8FiFzbNbQ0mJHlUIKUehWakIpX7LlQh7
	78Tn0WjTBtqSjJ6LxZGOQS3VIKHgG+PQUYIkswd/JRuAIyV+uHXxILi085zR+GUOff9uuJ5N8CIJE
	zlO2iT5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upHI7-00000001FEY-2278;
	Fri, 22 Aug 2025 02:14:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upC9H-00000000WmU-3Pbi
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:44:41 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57LKUQ7d1193217
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=hm2agGAshuZsugLZ0p
	QzuhSejxyf1vg4VI5sjJjTHIk=; b=q7oVnO/F+6tqg0FT3m84IAsCH/DCGKGjWL
	4IKjGbhd/+gemk/3P5LALqwkF+nAmCacz2Qyo1ecWyQI5UkYHvDy/TXj7aXMUU07
	SxeNI9kNkIIgjoIclwcBzm311NuZbNV6C0jHyX293tL2Xo3BDP1Lz4usqh+9PHTF
	yMq8KZSiqWFpdb2e1cRJiqU79ng1XGx1tZSxhp85BdT1/NXO8XDvV4giYrjgfCdl
	VHYQ0tBC9ntwotXVibCy5/1DwIQH3x91Zu5LckqDdbdSIAH5EcKA/wpylspCSq1d
	/nournMjajjRzXOGWimsyNXyMpINe9TodFsN2wstGWjzJqOMKKjQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48pa5a09gv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:38 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 21 Aug 2025 20:44:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 99F5ADAAF46; Thu, 21 Aug 2025 13:44:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] block+nvme: reducing virtual boundary mask reliance
Date: Thu, 21 Aug 2025 13:44:18 -0700
Message-ID: <20250821204420.2267923-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nphIRziqgvanZPbOWkx_Vv-c96Z0snqE
X-Authority-Analysis: v=2.4 cv=F9UOtqhN c=1 sm=1 tr=0 ts=68a78536 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=t7V0oaV8DjCZFRwKODIA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3NyBTYWx0ZWRfX/RrZHhlcDfXo
 ZTcFvL/bB5GaV+GlaNL5OHUI5tcljoono7KqKQF0ZBXu0pBy5qKmI3sgxICMnwRxZmlez67VEoa
 UHsxvr33QxNSGs89T8I/ZUk0NW+6GEBKbTEzPg/51rL5db5WJZ9PdcW2HWaGWHtsCninC1q2IsX
 RlQytRpSgcp3nwHqy/OMCsj9NjxxIlQLElPT8jxvJUp3D/Bz3tQiQVj/9WPe067PMzXJnednNXH
 uje8kpnFQEPylDc1n+jmp01DFANAbEJa8YulIrRgxL/3t+X3+ARGN8iC/rn2hsiBVrkpbZFCFak
 Df8rB8gnKWnJP/gBsJPVcHW7jyORXGt1VxC1njCBAgmUH+IdLPaRNAtzh8xLNVpzUjXhjwR0A3A
 pV7yA21htpB05Ff1K5gqF3XIeyTn0wzA6XyQAWOze0cKBaQ8uXlL/iJ1jogVujLXOR1M6HVg
X-Proofpoint-ORIG-GUID: nphIRziqgvanZPbOWkx_Vv-c96Z0snqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134439_975080_0F376256 
X-CRM114-Status: GOOD (  16.59  )
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

From: Keith Busch <kbusch@kernel.org>

Previous version is here:

  https://lore.kernel.org/linux-nvme/20250805195608.2379107-1-kbusch@meta=
.com/

This patch set depends on this unmerged series for flexible direct-io
here:

  https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta=
.com/

The purpose of this is to allow optimization decisions to happen per IO.
The virtual boundary that NVMe reports provides specific guarantees
about the data alignment, but that might not be large enough for some
CPU architectures to take advantage of even iif an applications uses
aligned data buffers that could use it.

At the same time, the virtual boundary prevents the driver from directly
using memory in ways the hardware may be capable of accessing. This
creates unnecessary needs on applications to double buffer their data
into the more restrictive virtually contiguous format.

This patch series provides an efficient way to track page boundary gaps
per-IO so that the optimizations can be decided per-IO. This provides
flexibility to use all hardware to their abilities beyond what the
virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v2:

  - We only need to know about the lowest set bit in any bio vector page
    gap. Use that to avoid increasing the bio size

  - Fixed back merges; the previous was potentially missing one of the
    bio's gaps

  - Use pointers instead of relying on the inline to generate good code.

  - Trivial name changes

  - Comments explaing the new bio field, and the nvme usage for deciding
    on SGL vs PRP DMA.

Keith Busch (2):
  block: accumulate segment page gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c               |  1 +
 block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            | 10 ++++++++++
 drivers/nvme/host/core.c  | 21 ++++++++++++++++-----
 drivers/nvme/host/pci.c   | 16 +++++++++++++---
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  8 ++++++++
 8 files changed, 87 insertions(+), 13 deletions(-)

--=20
2.47.3


