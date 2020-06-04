Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 17:27:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE43C206C3
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g23NYwa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE43C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=g23NYwa6H1t9WIFngsQkAIl5F
	8GQSpOIG7cZ4ZKM7OULj+XauuKse1eLvN4jCHOdSwPUEc1DaDEi2l6TzjGThhl8EuuMNK/T6L5oG3
	lSYHhSlFnJxwa8d7OhRAN10XYtkEwNvX6RDf+p8whPBsV5/xWn+rL8JfpjfgztuEJXi/ICjMdl4AS
	u2ijC0OtgZlhEl87yCV08GnBgQ/xw74blM+1l7YhRwlr/RRQtAifvhpnWL7Mn62CX9ZyxmYL6rvkW
	MlgR0VRHzLdFPS/BfQ2T1+Z45ghiWFt/wtaPKRVuFBpnGxNPMNzU7SiuzWqUA8RkvwtYB2Aoxwt5j
	QIoVq7Hew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgteR-0002uX-Nz; Thu, 04 Jun 2020 17:27:35 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgteP-0002u3-Ce
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 17:27:34 +0000
Received: by mail-pl1-f182.google.com with SMTP id q16so2467609plr.2
 for <linux-nvme@lists.infradead.org>; Thu, 04 Jun 2020 10:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=gm+3cikfBCyrIZtVX+4k6Euhfv2pcfMy+MWVwOhFnMq0/RBytG/MukYDb4VhT+YZjC
 cbVkHkm5yAxrm6RXLqylbZaZQbsSORMoqeuQBqjR+rnMIpFIn9qt7FC/ExfBnw5o2Mxw
 Pru2PIzOxo+pR0HbwTotgzpUEcDboeKD5KN5LtJDcC1V54auMCEwTem3EC9IAxkL03ha
 u7uZfLyQxVF20vbafwddwj5CclxFBuDi8wOG0igefc8OKnry0YxwozO0ahK/mpPNFpn1
 z6dUEjNuDWREq9FtPopObJsRFWjGSHvI20+ICYuHM3gXWiY8xfEgdc5RnnS15d3VPbkr
 XGDQ==
X-Gm-Message-State: AOAM533EbwH1w219JdKDp635EGaPfzRFOMLRO+QdTXB67deixglZ3isi
 hLPGa0CkVCFd52z9zqycpB4=
X-Google-Smtp-Source: ABdhPJyL1tI+b1vr9SFtcOlyLvpUW6La/YS1cbA4aTDXYI3JZ9EphShAM8mb/RuISC4PsFwWDGsrZw==
X-Received: by 2002:a17:90a:9f8b:: with SMTP id
 o11mr7195069pjp.179.1591291652516; 
 Thu, 04 Jun 2020 10:27:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:35c9:507c:6c7a:323b?
 ([2601:647:4802:9070:35c9:507c:6c7a:323b])
 by smtp.gmail.com with ESMTPSA id n189sm3102183pfn.108.2020.06.04.10.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 10:27:31 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To: Dongli Zhang <dongli.zhang@oracle.com>, linux-nvme@lists.infradead.org
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4ec2d9e-b08c-19b2-16a5-93520ca13c2e@grimberg.me>
Date: Thu, 4 Jun 2020 10:27:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526042118.17836-1-dongli.zhang@oracle.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_102733_425491_2DF5C8E1 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
