Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16079C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 04:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBaYkCq2UOecKkI/ZcXaXDVPy+SEFxbUDpVc4bdCZmM=; b=y2HXOmlj0+OY6mfgk2rJD88/Fk
	ZuhXk0fhdgvGVBpdfrLofHptUmHyJl/1uwFE5YxW4aSHpktZ8NdMCXgJuVno+CMpFM9hUzEBPuPYR
	8DAaHSON+Lxu6mEBiJieoEk8flCmVU50PW8SZhMCAFeWR0n5YIOBB4sqex4GcL/FXd9HpkKlvt3wb
	oGCbTlECCjJlO4zggtj4+OIsGSNUzFxy3Dia0/P7cFvXokN+OORcHq0Hq3ROfE/fYsV2MuYkMKq+E
	fnIMkU9C+ur+iAcOrh0XNHNLs5joEM+MfYpmwd144sDFbnW9JXxQ13hrTb0TwKwbMdFwmTICIE1j9
	EgjHabow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBUH8-0008by-Oi; Wed, 13 Jul 2022 04:47:02 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBUH5-0008bX-UF
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 04:47:01 +0000
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so1703246pjl.5
        for <linux-nvme@lists.infradead.org>; Tue, 12 Jul 2022 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBaYkCq2UOecKkI/ZcXaXDVPy+SEFxbUDpVc4bdCZmM=;
        b=h1H/+uf4FxW4bgT2t3lI+XGqdPLgtl0u4V9II5sch1nlT+lMFHYXepqKt3obshgGQr
         3HvlRGfLhGGuN/cLDAW+qlK3KCK5YFGagFcXTsXxI41AZhR0UvNjIOlpluv73F4bxF/g
         pFWma2sdbuCLVJtI9XiLV2fs42bsQjkzpvmWkN4oCL2sNl7r9G1b+YQyRp08KueMfFes
         c4o+4R1l23aSWaIKGanMB/60uX0VmGGgtKiBWNxIHEkc06LPSYVDvoQbvR1B5UwEmIHV
         dw1B4Nb9a9I4T9YxMEAxznmpehRy31heyuhIqdWkyGOAybIB3VCVbIEOmwToNh5BrTu+
         lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBaYkCq2UOecKkI/ZcXaXDVPy+SEFxbUDpVc4bdCZmM=;
        b=QclDNxWeFvZfxPwruoEFCStpaBmDjepcBqHqJj1+ELU9uOEg4oyo34YtmSFNxvnYhY
         jowqjtGEsmtAEwYL0EuTKbkfmUOpXMeGTAL6yGFeoQokC8aTX/8OJuPPVH9MgjgCaAls
         RZaqvH3X3UwvZkamBBJz9EdQEaWblgAudhm09exVbczbBCtYRi9EaGGnaYMSzCOy4jJu
         jy21/pkMQkadv+e9tjQvtWDiH+QfeGd2UHaxINcyk9GK4QAZYZb/RKOpWI1yeKSgs0b7
         u+2VwcHMSCVB0kwRw6rmKmPtYKY9N4lNTaBWJj4ctaHJQhOR7vbF6Trt9P7mStMWmvMc
         cEOA==
X-Gm-Message-State: AJIora9m6GpJqYJcUPw781CFCb9IX+dfoyAhjPTJc83AYn5b5OH/P5Oy
	cnnSzUqkMagKiRLvauvv+oo=
X-Google-Smtp-Source: AGRyM1t4Kvp3+MPAFYCpd5hlmg5MlCU8bpPTtIXAtIiqdQtJ+Yzx2cYW2gylT+SNs6NaoePwv/3tlQ==
X-Received: by 2002:a17:90b:1d02:b0:1f0:1c2c:cc64 with SMTP id on2-20020a17090b1d0200b001f01c2ccc64mr1836081pjb.52.1657687618757;
        Tue, 12 Jul 2022 21:46:58 -0700 (PDT)
Received: from localhost.localdomain (pcd364232.netvigator.com. [203.218.154.232])
        by smtp.gmail.com with ESMTPSA id fr14-20020a17090ae2ce00b001f0097c2fb2sm469316pjb.28.2022.07.12.21.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:46:58 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: hare@suse.de
Cc: ak@tempesta-tech.com,
	borisp@nvidia.com,
	chuck.lever@oracle.com,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	simo@redhat.com,
	kuba@kernel.org,
	18801353760@163.com,
	paskripkin@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH RFC 1/5] net: Add distinct sk_psock field
Date: Wed, 13 Jul 2022 12:46:37 +0800
Message-Id: <20220713044637.106017-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <325938d3-bb82-730b-046c-451dde8cc14c@suse.de>
References: <325938d3-bb82-730b-046c-451dde8cc14c@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_214700_016026_F1A9B7C2 
X-CRM114-Status: GOOD (  17.79  )
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

>On 4/18/22 18:49, Chuck Lever wrote:
>> The sk_psock facility populates the sk_user_data field with the
>> address of an extra bit of metadata. User space sockets never
>> populate the sk_user_data field, so this has worked out fine.
>> 
>> However, kernel consumers such as the RPC client and server do
>> populate the sk_user_data field. The sk_psock() function cannot tell
>> that the content of sk_user_data does not point to psock metadata,
>> so it will happily return a pointer to something else, cast to a
>> struct sk_psock.
>> 
>> Thus kernel consumers and psock currently cannot co-exist.
>> 
>> We could educate sk_psock() to return NULL if sk_user_data does
>> not point to a struct sk_psock. However, a more general solution
>> that enables full co-existence psock and other uses of sk_user_data
>> might be more interesting.
>> 
>> Move the struct sk_psock address to its own pointer field so that
>> the contents of the sk_user_data field is preserved.
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   include/linux/skmsg.h |    2 +-
>>   include/net/sock.h    |    4 +++-
>>   net/core/skmsg.c      |    6 +++---
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>> 
>Reviewed-by: Hannes Reinecke <hare@suse.de>
>
>Cheers,
>
>Hannes

In Patchwork website, this patch fails the checks on
netdev/cc_maintainers.

So maybe you need CC folks pointed out by
scripts/get_maintainer.pl script, which is suggested
by Jakub Kicinski <kuba@kernel.org>.

What's more, Syskaller reports
refcount bug in sk_psock_get (2).

In this bug, the problem is that smc and psock, 
both use sk_user_data field to save their 
private data. So they will treat field in their own way.

> in smc_switch_to_fallback(), and set smc->clcsock->sk_user_data
> to origin smc in smc_fback_replace_callbacks().
> 
> Later, sk_psock_get() will treat the smc->clcsock->sk_user_data
> as sk_psock type, which triggers the refcnt warning.

I have tested this patch and the reproducer did not trigger any issue.
For more details, you can check the email
[PATCH] smc: fix refcount bug in sk_psock_get (2)

