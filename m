Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A51320838
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IPV6pFWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A51320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xJkKbL6Uw3tioeBJu0IFLTKpRlbQOjd55+yuVzV9prY=; b=IPV6pFWxBxAaYNG/btDpxsMnX
	9sbBCe45EaIyTFFbP5CELrUt2PkKHRBlgz/UFEnO5acZXCpq48eBpce3w1hr7ftLY830S55AEYzLm
	22NOh/RD9wcxgLFGc4Bzpppq5a3NNLzgrcWgBFVN972j+A+kSkU9A5kq8XWGdRNf1896QBn+NiI+s
	o43iJQUCN87xhoh1/wUbcieMOHAOe2LPJgaT+MXDgPaojilOu7rA3bcTIDENu2qNFXgcfCG03AzpY
	Awx5bL0BhzIJ7d7jNOG25QBRiMvfJWjrC+UtmR5/D2DxgdQXL6y97I9avO1kMViO/UxsZEytt23k7
	ZHY8Hk7/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5rRR-0001Fl-H4; Wed, 12 Aug 2020 14:09:21 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5rRN-0001AO-LX
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 14:09:20 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Aug 2020 07:09:11 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::2c17:bc91:18b9:c598%3]) with mapi id 15.01.1779.004; Wed, 12 Aug 2020
 07:09:11 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH v7] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v7] nvme-fabrics: reject I/O to offline device
Thread-Index: AdZVNtfQwLqufTQARFyP/r4WNKASYABPsl96AOTmf4ABqzo0AANp/vvgAH+X+wAAFHW+8A==
Date: Wed, 12 Aug 2020 14:09:11 +0000
Message-ID: <f3166282a6cf4f5c8b39ade6b0453395@kioxia.com>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
 <20200714110435.GF16178@lst.de>
 <52eec097-606d-1e2c-edc3-81b60807ad5c@grimberg.me>
 <45d34d7927354b6393859048c257cb86@kioxia.com>
 <ad7afffa-40b5-6cf8-6dff-21a32328c552@grimberg.me>
In-Reply-To: <ad7afffa-40b5-6cf8-6dff-21a32328c552@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_100917_715796_6C2DF228 
X-CRM114-Status: GOOD (  10.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/8/11 23:56, Sagi Grimberg wrote:
> 
> I think we still have a question to why is this fabrics specific, and if this is
> needed in fabrics, why is it not needed in pci as well.
> 
> Keith? Personally speaking, I also share Chirstoph's opinion that if it's not
> clearly fabrics specific, we should try to make pci and fabrics unified.
> 
> Your thoughts on this?

PCI doesn't define 'timeout'/'number of retries' for reconnect of the controller.
And the controller shuts down immediately if controller times out while starting.
NVME_CTRL_CONNECTING state used as transition state in the
nvme_reset_work() procedure to save similarities with fabric transports.
See below quotes from pci.c

1. 
----------------------------------------------------
Quote from nvme_timeout() function (pci.h)
	/*
	 * Shutdown immediately if controller times out while starting. The
	 * reset work will see the pci device disabled when it gets the forced
	 * cancellation error. All outstanding requests are completed on
	 * shutdown, so we return BLK_EH_DONE.
	 */
	switch (dev->ctrl.state) {
	case NVME_CTRL_CONNECTING:
		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
		/* fall through */
----------------------------------------------------
2.
----------------------------------------------------
Quote from nvme_reset_work() function (pci.h)
	/*
	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
	 * initializing procedure here.
	 */
	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
----------------------------------------------------


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
