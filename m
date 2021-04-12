Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86999C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 05:52:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA19D600EF
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 05:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA19D600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yVBYwQlORSLd/LWhU37vx+H0rryux0QQNFka5f4VNBQ=; b=qgCWDFidcOcba/osUTNxMQMSm
	Ze9tiNfL4iv/Oc0LxIHce6d7pwaqg26eIM0QuE8epryTluBskihF0sbk7ymStfqHfdgbiDfXC29hA
	mBVEKv0YF3RNNhp7baKP1JzjIRR/swoC8R6svVM77yMxr4hyW+b0eku/oXIweuPecUZYS/JDIcTAI
	i/zmor4cgmSCMPckOW9AC0+UUG6woXeLvlVFelwwvo1GySpPv5mZdEi5MXxXidWqrR3ZpikDg/Ewu
	tI+suvaENpthzU6m6f3eHsMkw/0dIFe9ahQAm5A9uh4WBVsWiau3nbEsc5lhju9smAUPk/Y7/wPGh
	xaFtlE+NQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVpUR-005lEg-S9; Mon, 12 Apr 2021 05:52:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVpUN-005lEN-Kr
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 05:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PQW16o108GUzplbvn+vq41NytwhSAAUnLN+4ln+XQLk=; b=1b41ETPiQCO0nyoVpEI2nzsoEK
 ljY41PWMrMaxV6k6KaKBBdkAJ9+Bsih1umjA+fwBPLCnVLe46zaB0K1TGznVB2vcwLcbs19SySFO3
 zfHdTgBuzCHTnShUOR1BZOWX9CX7l2Otf1iqVHiLJshdt7KWNjWl8geQSl7utKVU3bFDO6SjpmuYs
 gEbwAn8V7JGwY4YaC2JQjJ+FrDWqpl+TD/anfA8Glh7qj77lhfZgNWIDy5SjhK1hW+NuPXwXAvjRs
 0cYYxE6AK1alvFmnAf85WBbrdnQGu12dBf3LriCEdVXYzPbwIvsYkY2P2iCoppXB5PkVQ374PvRo3
 wP5XymBg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVpUK-005tKL-Qy
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 05:51:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5A44E68C4E; Mon, 12 Apr 2021 07:51:48 +0200 (CEST)
Date: Mon, 12 Apr 2021 07:51:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, axboe@fb.com,
 hch@lst.de, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH v3] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Message-ID: <20210412055148.GA1442@lst.de>
References: <1618115015-8545-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618115015-8545-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_225157_059342_4BC85998 
X-CRM114-Status: UNSURE (   8.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please split the PCI part and nvme part into two patches and make
sure to include the PCI maintainer and mailing list.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
