Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE92C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0BgaW9t8GFER5QecxVkFsHrVi3gO/4V5KAZgJaiRYBs=; b=1Jorq+WmeUG+ajNV//MNMoQhzc
	ffDOxgii9yztqCoTrbeNsBidqtbSp3EVyVNtJHALl7e5pUEw4X+TieRTFhAFM0knPPjN4V2b0fVt+
	SAYodcwtrxQSR8nddM6gi2U78q+QLb6ATgEj0pUlQZp2Xaxy6IMGLS9S+R2kaPA9tTqvQmAzacIZT
	9vVuR9JYpEb5L2tnWXga2acXndrdrW5hoA7MYe8gPsyaxkzuVwLBf0HeeMzr1is5B3Qn2Vr3u7cKZ
	7r1hjFqdKk9SMaBRqDTBHiVGGfL+cW35AhB+W/iTtXRCkB1mPwSmZhkmd7mwPETR+Jz2LIBA5ueBv
	cN/yHQ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxP8t-006fgU-DD; Tue, 22 Nov 2022 09:00:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxP8r-006fe0-P8
	for linux-nvme@bombadil.infradead.org; Tue, 22 Nov 2022 09:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0BgaW9t8GFER5QecxVkFsHrVi3gO/4V5KAZgJaiRYBs=; b=iBrsqKTHZC+xJyCtTAHs1TPMmT
	XJKHAAyQwT3fUH+CNahZMct0i+0yQRNiyT4u//Zecs5Gxy+FSeswpU3Dz43iLZCoIY2cbITb2fTWU
	85YHXnei92xxXObyB/N3Wmz2AbQrqBQg4Kxv1+Xkmp2SKOMZzh1sexyZJA+OFdKlz+i3eoAXZWmRX
	QzADoOmRMibBkKwtFF3To6VjlgBkqsPH4iCLDtLR08YTeA3lr2pdCaKdURlnQsR7PB53QSu2DMeST
	H+jMsnhNpHaF8YAz/OxoUKWit4/ENEAM0ChvkDNnNMaENWLjV+GJe2ZTpin46mtjIwMaWrjdbU2fN
	FgZQlCUQ==;
Received: from mail.axisfairfi.com ([94.177.230.134])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxP8o-003Nu2-5A
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 09:00:31 +0000
Received: by mail.axisfairfi.com (Postfix, from userid 1001)
	id 3C9AE8245E; Tue, 22 Nov 2022 09:00:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=axisfairfi.com;
	s=mail; t=1669107626;
	bh=0BgaW9t8GFER5QecxVkFsHrVi3gO/4V5KAZgJaiRYBs=;
	h=Date:From:To:Subject:From;
	b=PJeruhXJo8TqO1qHd5Qsgmr9f4RI7oSw6/k82Z8FtoCkJBoIRlHlWm4v8KMrs8HMh
	 yZvv1oE337zpFM2qe7YYbA2VhzeF9aP2KSFaFXtsgqPftkTyG09yLfEGiqK50cPItG
	 mCRVK4JIGTyTOY+UXuw0AZ4+4Yh+LcJFF4PJ3IsPo35aG48l4IViVMv2DOx1ID3Cp9
	 /7P5bmspeBcg/QziZAfVhxsG5atzHnR6vpJ5c+OBEatgXj2R6w1IsDtQ1qXVsg0qej
	 4rNw6oUHUiUqqb2437nZcgTgI9DIb7JJu+OKyxaPatLby5zNY/aVNDorBXB6fSrjtP
	 8PX/LcfFyhLtw==
Received: by mail.axisfairfi.com for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 09:00:23 GMT
Message-ID: <20221122074500-0.1.d.nbg.0.fu4mmthd4v@axisfairfi.com>
Date: Tue, 22 Nov 2022 09:00:23 GMT
From: "Zbynek Spacek" <zbynek.spacek@axisfairfi.com>
To: <linux-nvme@lists.infradead.org>
Subject: Silikonmischungen
X-Mailer: mail.axisfairfi.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_090030_350273_F84BBD9D 
X-CRM114-Status: UNSURE (   2.31  )
X-CRM114-Notice: Please train this message.
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

Good morning,

do you need intermediates for processing, plastics (e.g. rubber) or silic=
one mixtures?

We provide a wide range of silicone rubbers with various properties, sili=
cone mixtures from renowned manufacturers such as Wacker, Elastosil LR an=
d dyes, stabilizers, primers and anti-adhesive additives.

We also produce technical silicone compounds with increased resistance to=
 oils, resistant to high temperatures and water vapor, conductive and man=
y more.

We provide fast order fulfillment, timely deliveries and cost optimizatio=
n.

Can I introduce what we can offer you?


Zbynek Spacek

