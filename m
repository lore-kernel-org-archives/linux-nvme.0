Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F107C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:07:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38B1206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aCovQY5S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPubdvMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38B1206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MkrKTZpVlac1gH8uhKFojNwaabe8maPzX1aq/b5VQXQ=; b=aCovQY5SCM6Su/Y6fiw75nK05
	5bXEaqSH5eKcxqnss+lfHL2pom7c162SQzFm49nZTJEFt8spjxACxR1xgcQTy6IMB+tgSCZtKFsiJ
	AxLwWClNxUpqnZOEOatd1s0kN3n0Y5vmfVEpWjnxAjzmyHGKusNVchRKwe76vXaDRntnRdkgNZvUH
	z8Fxcm4tXI5P8luD56y3GkCSKbjHh3hZrHhfmpi6kAut9n4yApCCGTbtZEq42qLNbD7/mUilFxx1W
	YJ5nICybFr8JcIxcfL1nYIG8ia887zFkSZq4leLggeqrP+sK+qI+0VB27BYGyY3nA/rVrZkd4LcfR
	RQ26cYq6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khYyR-0002ik-2z; Tue, 24 Nov 2020 14:07:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khYyO-0002iF-H0
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 14:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606226832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l20bhJycc9x14kM2+fmmOrl3TACGnUBVSRfcgPItEmk=;
 b=bPubdvMhar36K0A/2gj6Gswc4tp+2uQxxQIoFTEW+uOToz5WxO/F4sMA38gaLqEpHl7GIn
 clEsFqnFL6rkfSIdcs8dIenBBgSUvvG5WiipXBNi2OwTzK/+Lws/nz/phvv6wVBdNQ+hlY
 ag/GAwcsWo1Ztiu0Jm4hpy8EoagaqtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-6gqhqp7wPkyd0_kAR_su4g-1; Tue, 24 Nov 2020 09:07:06 -0500
X-MC-Unique: 6gqhqp7wPkyd0_kAR_su4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 762DF106F6E9;
 Tue, 24 Nov 2020 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 655C619C44;
 Tue, 24 Nov 2020 14:07:03 +0000 (UTC)
Subject: Re: [PATCH blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-5-yi.zhang@redhat.com>
 <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <f4b82046-1ab4-5c44-c3d3-fbdfa17f927c@redhat.com>
Date: Tue, 24 Nov 2020 22:07:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_090712_630450_E545B1F5 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/24/20 11:29 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> With bellow commit, the version will be updated base on the tag
>         ^^^^^^
>         below?
Thanks, will update it in the v2

>> fbef6555 replace SNAPSHOT with auto-generated version string
> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
