Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A0CF8568
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+C2rkp7jlJkARupnIKj+20eLg26RHbLCuvTdEBiXbNU=; b=eVs7FSZFUt7+fTko2Mg3J5KfNe
	HPRUovCO1BDr24mOlk9WnO61/YdUrjKvm9zUYgXFQTZqy+8jtrzfDO/TelyxOEsbWwkyigUMiELtl
	2gpvQq4AkbYBmy6zFnJKRGPPAVEW4wirevbtppHiHU1tU/SFcUYQgkyZFnSr1ecnnMuZuP2eS7uJ3
	vLm2nteVkWT2+gaqgV6nClMacO58N/rJViYWrXQGyOPUrULhx8+oe6Iac0kiMBJoL/Os+hi75IjW+
	mWZeeu175j2LIsO8yuTvFxox2itIFGs9KRdnneHjpFIh7UEE0KyTJJ4BBr2D5woG3nudHay3G9G5f
	XbCRYd2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swGjy-00000008TGp-1UtE;
	Thu, 03 Oct 2024 07:59:14 +0000
Received: from mail.bytebrigadebuilders.com ([80.211.239.163])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swGgb-00000008Sh6-04ZS
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 07:55:46 +0000
Received: by mail.ByteBrigadeBuilders.com (Postfix, from userid 1002)
	id 5EB04845A4; Thu,  3 Oct 2024 09:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=ByteBrigadeBuilders.com; s=mail; t=1727942140;
	bh=+C2rkp7jlJkARupnIKj+20eLg26RHbLCuvTdEBiXbNU=;
	h=Date:From:To:Subject:From;
	b=WWCuNf55px2xG/83zRkepFclqXuxIJ0IqYWicSYbY2VlZfboV9fgcuZ76LuSh+uEh
	 S6J+diYg7wLSZtMMYWyBzAkPJfqRJ7KVGnIMaW3PvYXJ8qyzDVMNdsKHsDQpFNqig/
	 y52n5xc0f/M6ZVSyGswFZY7iktOdPaFXHbrMmJkGGW2hKE/3h2LWmUT3mCVCJkIbgB
	 +5+eV3Qfym4YLKJyD3NO8mtgw66kWVp9mxfprTpG3F4XqB6tAo7EIbROiVUDsmG4+I
	 UTTAjf+yBYlYQhxEgQFjHM1FdvJ9EDN5zQFv8E27Zb03OaLUUkH/BK+6//zY3x0WGH
	 tYbfea5Cn9fkA==
Received: by mail.ByteBrigadeBuilders.com for <linux-nvme@lists.infradead.org>; Thu,  3 Oct 2024 07:55:24 GMT
Message-ID: <20241003084500-0.1.ac.vb5i.0.kzsjb9d09i@ByteBrigadeBuilders.com>
Date: Thu,  3 Oct 2024 07:55:24 GMT
From: "Jan Polasek" <jan.polasek@bytebrigadebuilders.com>
To: <linux-nvme@lists.infradead.org>
Subject: Quick Question About Collaboration
X-Mailer: mail.ByteBrigadeBuilders.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_005545_218515_3DBA73F6 
X-CRM114-Status: UNSURE (   3.03  )
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

Hello!

I am very impressed with the products and services you offer.

I thought we could help you reach a larger audience with your offerings. =
Would you be interested in collaborating with us in an affiliate marketin=
g campaign?

For example, our program for a company in the e-commerce sector resulted =
in an increase in revenue from 8% to an impressive 19% (on average per qu=
arter).

We achieve up to 13% turnover in GA4, while standard affiliate networks g=
enerate only 3-6%.

Would you have time for a short conversation in the next few days?


Best regards
Jan Polasek

