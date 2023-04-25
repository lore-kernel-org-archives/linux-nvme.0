Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC470C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lb7kPRxBCostMHeoI61AIP98yEL6JxTcH1nHur1zQrQ=; b=cmREcWpo9HGsLKITeRjxgtArWF
	QJJDl8dUJr4JfCF32rLibQAAnSmZT4M3+eQxaAhb3+sGNGwModxVsf7Mq6KLBkjiSm3L37jqL+qSr
	gOprBbnF6Oc9bCSQkyVr/aU0BzZG0fAdvHfb2GOlMq6iosJS+T6bjxTCeYZCCSgLrUWdHEdFHm65w
	ijkQG0JULyXYVhSNu93BNoYJkh9VwxrLd9gpK9PSjc1We/EeGhqZNaTJVKlcs3lvYeC+KPhc58C+S
	WumINknixzSQuLp80Hq7qeC6kR4RRVseO93xGFItpv5TxJTHsry8W22HMREaF475zq5IDiPBQ7vY/
	AJX/ja9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prRwn-002ODg-0H;
	Tue, 25 Apr 2023 23:19:45 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prRwk-002ODE-1h
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 23:19:43 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24756a12ba0so4444777a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682464781; x=1685056781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lb7kPRxBCostMHeoI61AIP98yEL6JxTcH1nHur1zQrQ=;
        b=bsrqGXtSspe9heuz3gnypW2fqhXjKQtoUg+zNWvP1QeaQzfFuQDE+TCZMa6TPNvN6s
         K9NKGQRFv7q0vfhRUm8Ylo0VTE27U61IiJGNZlo9N9cSq0qxbXPLRuleaYNDkZN1S7Tb
         F8gs8kO+M2hD4MnOfzYUFcrrUvh9G3gvY+WSYLPpP4MdgbLzbM2XvOyPHKxe+UXuygdW
         sq/7ck9rNnUsTj+4Lo4Xkh7R5V2gM8VWXnvxhmk0fc+52cxj+KTTtuOkfLmkoRa4wCuM
         Zpyct+U3J2zHPeEnvzGbyZYxNUmWepk2rFzur39RRFJT9Bn+IhpbFZq8KNVhIjNTdXBx
         otrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682464781; x=1685056781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb7kPRxBCostMHeoI61AIP98yEL6JxTcH1nHur1zQrQ=;
        b=TMwQaH0V7h12S/ib1Kjg0squhVxvth7gleG4XUSY3WVOEh87gb9qXGBSR5iXiLZe4P
         SxLN0lO47MqkLXcFmfKnDgILfWtmkqFpsX5uAXPqeLqZe4vm8RoxVVJTg8nPyPuS0HsF
         ZW0QxG5uqlWzO2WCFDP1YNmR1xILQXM0DnmbM2Cr8125AAGetuzuHpHsL18aEd3Y+A2N
         vALifw0YcPX3GE57D9CYgLP+5KqiW2IAajxuOu8Pmo52UyiQ6I1bG+ZWoaMs8pDbf6Hl
         DMITKCMjAryPMX1sJlFI/zWlZzW11dcjUmSN9sjxN75q7OOVl25bB2abpOrg4pPRNfho
         Tx6A==
X-Gm-Message-State: AAQBX9eDyKNNWosMYXKOqo1IZ7E5hGNqkBhnRbLGuEg2mPoabUPfCL7t
	7Dkgrht4Mc7W3UPRjI1f0U9LMy22n3wZUCDagp5Zzj2z3iuN3Q==
X-Google-Smtp-Source: AKy350bNimJYuCxj/IZuE3Ei+RKJM3wiiuWbDv2n7kFOJo4/7ncy4atd8Kn0pFA7CPTehwygs5/HQ6+6ztfvZrtKYVg=
X-Received: by 2002:a17:90a:e7cf:b0:23a:ad68:25a7 with SMTP id
 kb15-20020a17090ae7cf00b0023aad6825a7mr18134035pjb.2.1682464780726; Tue, 25
 Apr 2023 16:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230425211836.14283-1-irvincoteg@gmail.com> <20230425211836.14283-4-irvincoteg@gmail.com>
 <ZEhJ4EE5JJryPBly@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZEhJ4EE5JJryPBly@kbusch-mbp.dhcp.thefacebook.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Tue, 25 Apr 2023 20:19:29 -0300
Message-ID: <CALL+9eiODcCmnkH6tWc7_Jrm5z02UhjRHKf9wpampC3CWC6t8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme-core: preventing double freeing in ctrl release
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	chaitanyak@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_161942_605993_32298415 
X-CRM114-Status: GOOD (  12.48  )
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

On Tue, 25 Apr 2023 at 18:45, Keith Busch <kbusch@kernel.org> wrote:

> Isn't the problem that the nvme_put_ctrl() in this function's 'goto' error is
> doubling the rest of the unwinding, which means your ida_free() is happening
> twice?

The nvme_put_ctrl at the label "out_free_name" in nvme_init_ctrl,
doesn't decrement the ref-count to 0 (thus doesn't trigger anything).
This is because by the time we get to it device_initialize and
nvme_get_ctrl have each taken 1 reference.
However the problem indeed arises from the fact that both the teardown
path and the release method (nvme_free_ctrl, triggered by the last
nvme_put_ctrl)
call ida_free.

> I think instead the nvme_get_ctrl() should be the last thing done in the
> init_ctrl() function, then the rest of the cleanup on error would be simpler.
If we were to put nvme_get_ctrl at the end of nvme_init_ctrl, we would
still be facing the problem.
This is because, ultimately the teardown path must clear the ref-count
of the controller before exiting the driver
and this will lead to the release method being called and doubling
some of the unwinding done by the teardown path,
among which ida_free.

