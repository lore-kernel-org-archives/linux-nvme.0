Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A59C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ze8mThgJySrWJXzH7JN+8FmxJbjsDVsDjHr/AlqiXdQ=; b=aU8IIbsJpVPkPwcknFMsPxu79V
	JsRUBrO42Hc4Bnt3/7TGD1ZE2xRYUnAm8Iepcekp4ApFrm3JoPULdOETnLp+G4myUWRAAPhiH+h9y
	hjmHjySTyqT2rXi/lT3St+abkI9F82Yn6a440Zl7u9PNdSGr9Xt6yctk2yCQmEPXjomkvNTSZGeJt
	+m8l7SDtv3z9FPEgxk4HftLDt3MsysJYccu5ndc1oree1orbEMSL1Dngg5qRgU504NIN2R+sAa8yR
	7IerbBhpFMRK7b8531PRqRR/a+MTykfoKxqLzDQdnEsnFuMJlTGZdLP7CXOUWZDLODrDQW3eZEp6w
	fEwPGLCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxW9-00F7t1-L5; Thu, 12 Jan 2023 13:21:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxW7-00F7rw-AT
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 13:21:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 079C63F423;
	Thu, 12 Jan 2023 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673529674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze8mThgJySrWJXzH7JN+8FmxJbjsDVsDjHr/AlqiXdQ=;
	b=sMQ7QvIOX5/+8EkHerGXuI9vKUGzfGo5hqMvCI8VrWpR62590/CXzxoXqzVw3uV6ZzlR4v
	d1etqAxJysEc8VwpCpZTnbiK/CxX17ZwDSeUpRjTow/ioU570S3aHWqrzw/NJEkR83AINK
	tyGpw7Ler51udLRpx/5a/4VgcPx5xTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673529674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze8mThgJySrWJXzH7JN+8FmxJbjsDVsDjHr/AlqiXdQ=;
	b=GM84tuwvluoQqFGRQ0RsKlUKLha0dAEnHaQ59tbe5rxvdbtMio6WajG34kS9C9M1aD5l2h
	VlqezCg5Hi3zmUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7A4613776;
	Thu, 12 Jan 2023 13:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o3MgOEkJwGNEYgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Jan 2023 13:21:13 +0000
Message-ID: <c7670778-be84-a5e5-6915-d6126a20ac3e@suse.de>
Date: Thu, 12 Jan 2023 14:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] nvme: replace the "bool vec" arguments with flags in
 the ioctl path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230108165033.380842-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_052115_535759_AEB5E60A 
X-CRM114-Status: GOOD (  11.62  )
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

On 1/8/23 17:50, Christoph Hellwig wrote:
> To prepare for passing down more information, replace the boolean
> vec argument with a more extensible flags one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/ioctl.c | 53 +++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


