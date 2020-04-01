Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABCC2BA13
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 16:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEDA20658
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 16:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pDGmzcWA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Beb7luF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEDA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDCeyhMK394MHJCn96fT7ujk99ASnGoXUpD+9GzYZiU=; b=pDGmzcWAyDJmU8
	Qy/FA18rkwmlGjAQ4T2nkE3BFYN+F/Gj4OBZWhxbL3bRMAelS7qfavzNrgatrxg6M/cs1+shMziEO
	LEmpka8K1EEfmVu2ObGAY3tNsXIhTjiTMfNS48k23U3JlWtcBABlG8f/iZxh9vG1N65EVzJOvge/q
	mCs58e99gI1Ux2nDKuJpx5EgSzO0ujnoaZ/YSTHS/OFTYj97dMQ8SUT+Op3i2JI2FyWc4niTQ50Ia
	ZkZmVPcOOjYj45TaYdhDbS1X5wXS3YI6oYIGL8boTxt9t0SFkmMngIq9zfwTKIP3tLap4ZNvHoomD
	0N25GHi6aaxwiG593dhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJgKC-0006jN-Pp; Wed, 01 Apr 2020 16:34:44 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJgKA-0006fk-53
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 16:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585758879;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPIndGqtp47gmEnhOnLZsDcspTmJhJqJQwCdryuOuDA=;
 b=Beb7luF7mR/XjNBZXoDOjkMK8QC+LxY1alFo+0XUqTedf2TjI8JDHaItYCe91Ith72FKx5
 iONlm4OqkPZ0YeOZb8mmu/hPTyTWgkxryAtvn+neVar4ug4W4niPpnNLgr/gV+A3vzDgq0
 I6/AGRracOgmIv5YFo4GUW5RI1+gdSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-5rHOUhQaNY6d4Hp8pP2jNw-1; Wed, 01 Apr 2020 12:34:37 -0400
X-MC-Unique: 5rHOUhQaNY6d4Hp8pP2jNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548A6477;
 Wed,  1 Apr 2020 16:34:36 +0000 (UTC)
Received: from [10.3.128.6] (unknown [10.3.128.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD00996B93;
 Wed,  1 Apr 2020 16:34:35 +0000 (UTC)
Subject: Re: nvmet and stable API
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <d4060208-ec69-3211-277c-d151be302555@redhat.com>
 <c89ef694-b447-5e2e-429c-bc449b3c57b4@grimberg.me>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <cae7b76c-06a4-d870-22d5-ec09cd57354d@redhat.com>
Date: Wed, 1 Apr 2020 11:34:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c89ef694-b447-5e2e-429c-bc449b3c57b4@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_093442_480369_D8A8C3C2 
X-CRM114-Status: UNSURE (   9.46  )
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/25/20 1:58 AM, Sagi Grimberg wrote:

> We don't have an API for python. I sort of assumed that this will
> be contributed by the people that want/need it.

Maybe, I'm interpreting this statement incorrectly, if so please
clarify.  I'm reading this as write what you need for whatever language
to configfs.  This works and it's not difficult to do, but what to do
for persistence?

Try to write compatible JSON output across code bases and supported
kernel features?  Have everyone fork & exec "nvmetcli save"?  Write out
your own file and document not to use incompatible stacks?

Additionally, none of this addresses a potential race condition between
two or more processes with different implementations making concurrent
changes to configfs and getting the configuration saved with no lost
changes.

Suggestions?

Thanks,
Tony



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
