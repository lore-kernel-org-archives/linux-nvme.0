Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5009C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZmukAOCnSOid+c2oF+UEQAEl/Hrs5ILTK41Tc2jnrU=; b=s4qub7xb3ERcDzlmvNKsEONU2l
	Vgy3NMgwn+BweSdEEWlrU2LLwc8uG6BsM0OE7jeOn7ttRtkntfzbT3ri46aydjmDll9fwA56MCfPZ
	N2TCimX0ZloqfB7ZvHFIHzBYgPnuQvQasAen5jtM2XbgHCauWASLFPmod6fqrxau1lZFAMyvkerCs
	Xr9OUxImzKA6YFCLRgg3vEWGjk4aT9rCvBmkemJ6DRnRl1QFctMoleNwB/d/yjMzLRqsmx8otUQCV
	qGDahWgH/Cp5GmBw3Qqq9PiUvwjWi9JyIgPP+iFRWdF4Qz/6Btfy4Mt6dax4J5NjDIPoRdXUAO5Yl
	o6ejHC1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWgYd-00BY9t-Il; Tue, 22 Mar 2022 15:36:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWgYb-00BY9V-FO
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 15:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647963384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZmukAOCnSOid+c2oF+UEQAEl/Hrs5ILTK41Tc2jnrU=;
 b=N7vY90DPmk4N/nmobaxNhjoggJ7jhiQB7/gmWo9Ghux2tfT63Cu54YQrITuTN74Gw8Ysyx
 LlES3lmG3D08aRxhrJsOtIKO8irs0lnueuvh4HXJ//6bR9Tuev0/pOBqeFYQF9+qyzrRAk
 Pb33EECjx4tB9ryOu1QrtYREhOPXhTc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-AtzIqaAOMiylH9mh_SqJYw-1; Tue, 22 Mar 2022 11:36:23 -0400
X-MC-Unique: AtzIqaAOMiylH9mh_SqJYw-1
Received: by mail-yb1-f199.google.com with SMTP id
 e7-20020a258747000000b00633ee0cbca5so5655551ybn.23
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DZmukAOCnSOid+c2oF+UEQAEl/Hrs5ILTK41Tc2jnrU=;
 b=72lQpgI3+/5niu/o4fUgeTnLqAYEgUh+sWkd32Gi9+6q6bAipQcYVLYcxQre2HuGDu
 5a0E2s32co/IGDDrHgKV5VQSVpnIM4WXeAJ2v/6n/gqRyGJ6dtvCWx127u0qGd3CVTjX
 vv3mNzg/ThiSrvmM52tOqwG3xaJ7rq5mCyTPJwJziF19oVh0bp6ihofNP+scUB7G1kj9
 EHyq+w6pp/yFPPs6d6898LDUjzSON5Yzlo3hn9AG5X1K0kh7KgLfl5Fik3isnfJU1z09
 Yc8p0I5VJUSYu5vpckf9QBAi4b6WBfJAHL9vijvVQUjys5islKYMYmQdHbtC3csjmBMZ
 Qf3Q==
X-Gm-Message-State: AOAM531KqUmGpOmeF3EZ0cot/GPC0iF8v2MnW0Z2MJaPCMyVpATOhirA
 QAgJH6I1nw9/u2TdeRQZmD80Bo1BgmqqwLiu3Og5+fcMMD5ueXvdiWlifa0DPPQV0uCtEZtopBH
 xrYUqoD+OIzf7PVzv5gl+DcgvsjaDKe8CpQFR/dTem8g=
X-Received: by 2002:a0d:d143:0:b0:2db:dfa5:e376 with SMTP id
 t64-20020a0dd143000000b002dbdfa5e376mr31748665ywd.218.1647963382884; 
 Tue, 22 Mar 2022 08:36:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOqQLHmWeI5JWQ7ngNMnwA/AaErxjrfAQF5Qy937IBE4oNviHKiOM06bJQeLIXJiwPUMlWgG+qeCAAiawOq30=
X-Received: by 2002:a0d:d143:0:b0:2db:dfa5:e376 with SMTP id
 t64-20020a0dd143000000b002dbdfa5e376mr31748633ywd.218.1647963382708; Tue, 22
 Mar 2022 08:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-2-cleech@redhat.com>
 <20220322111659.GB29151@lst.de>
In-Reply-To: <20220322111659.GB29151@lst.de>
From: Chris Leech <cleech@redhat.com>
Date: Tue, 22 Mar 2022 08:36:11 -0700
Message-ID: <CAPnfmXKFuwDPZpSnFc1qpKAWmrw_NC3xPJ6OQnvkj2gOUaL0tg@mail.gmail.com>
Subject: Re: kdump details (Re: nvme-multipath: round-robin infinite looping)
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 lengchao@huawei.com, 
 dwagner@suse.de, hare@suse.de, Maurizio Lombardi <mlombard@redhat.com>, 
 John Meneghini <jmeneghi@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_083625_615849_276A7402 
X-CRM114-Status: GOOD (  11.23  )
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

On Tue, Mar 22, 2022 at 4:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> What kernel version is this?  generic_make_request is long gone, so this
> looks pretty old.

Yes, this was found on a RHEL 8 backport, we're working with the
reporter to move the test setup to something newer.  So far I haven't
been able to create my own reproducer for this.  I went ahead and
brought this to the list because I don't see any reason why upstream
would be different in this case.

- Chris


