Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B11C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96BA2073B
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lRYCVgay";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLBfNopg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96BA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y7qAp7LslVfWjt6EAUrRFYx8LOVXJB2OgjD0qm5txVo=; b=lRYCVgay7lZZUi
	z/ydWX+u5TOqBpXE811OkfJCkeunHnJsfLTBPIMzmFJCoJMK5y5SYTGr/CaqcqIa3BQISLz45SdeG
	7Jdw6MiSVrw0eWC0d+/qZqmEWqhA9JPd+p4YfKbBHWmOQ/Q1qw/hD6gPua3aP9UtfGxGOWDdNu4lx
	k3FfRmyzeRODBTpl/DrS5qO2bbgpQ2n5/bUxC3SoX0j5z5L+5WawPhpHqUH7sAHe0YlaW+5W10N2T
	iIc63Hl/3WTTR7r0XyRCr+JM+KIYX09/SdvQ6z27pj4rPCJy1NhA2amjNXQG+xdmoBnc0dilS+0RN
	LBkCYPAZKErg4Zeh/bXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK0x5-0003M3-J2; Thu, 02 Apr 2020 14:36:15 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK0x2-0003LW-HY
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 14:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585838171;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGy8reDpCYVqlodR/H3yQIpESJImOsn7IZxCxfmdSRI=;
 b=GLBfNopg8InJOZGTlcFwwQJCTCrladiUOk+4cl+ey7e90XWniX4wNHP4xZQYwEpuOEJtze
 JFY10K8zS/1FqgvOvlwmXgyVtJTgr4sCtcTbWQnnxhIfxy5jLLwbZ27i1rUY4iEA7r7H59
 vQHhLvGGmwxlOE62lZRdDFfdbsj5q9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-f2JhLBJoOdCeHCx4PsLfPw-1; Thu, 02 Apr 2020 10:36:09 -0400
X-MC-Unique: f2JhLBJoOdCeHCx4PsLfPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C32F18017F6;
 Thu,  2 Apr 2020 14:36:07 +0000 (UTC)
Received: from [10.3.128.6] (unknown [10.3.128.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 850E71147CF;
 Thu,  2 Apr 2020 14:36:05 +0000 (UTC)
Subject: Re: [PATCH] nvmet: fix NULL dereference when removing a referral
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200401231627.23553-1-sagi@grimberg.me>
 <BYAPR04MB49659E5E7A701C15128CC59386C60@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <56e3298c-f041-3a4b-28be-d611bfd5956e@redhat.com>
Date: Thu, 2 Apr 2020 09:36:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659E5E7A701C15128CC59386C60@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_073612_652667_97B6F5A0 
X-CRM114-Status: GOOD (  10.87  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/20 7:39 PM, Chaitanya Kulkarni wrote:
> On 04/01/2020 04:16 PM, Sagi Grimberg wrote:
>> When item release is called, the parent is already null.
>> We need the parent to pass to nvmet_referral_disable so
>> hook it in .disconnect_notify.
>>
>> Reported-by: Tony Asleson<tasleson@redhat.com>
>> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
> 
> This patch seems to fix the problem, Tony please confirm.

Confirmed

Thanks!


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
