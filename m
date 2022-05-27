Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89569C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QpiKqWZVtYeezTU24EvdDLlhApiuU/F6GkO8aX8b2Q=; b=DNFZnPBloUkd/ysuld2/qtJbyQ
	2IQZ31nltAzcqVQycnEBEpT99NEDIVKOueoWeCPVztz4806i/SqBEEC1Vu35gpejDCwKE4KLrAWaw
	9MbTniBYKkJmTWnj0622hCEweIYVSMNbj9WU48HikObytLVlbqDphEtKhBNTTnALZ3manxs4Z8gth
	FP6PAsIEzp83ujY3ux7up2wJp707yoB+fdS2UmizY85PG7HdzEzOvEsSLuZJMj7z4IB1YnwKsKX4y
	TpTAXpyOG/toTYbRae48OGL/081tK9XxrCMZ58IpmXdcwVncLNWegw7bmOl7xZco3X55QkkbO4Ro8
	F4pkagWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuX6c-00HK9I-Gl; Fri, 27 May 2022 10:22:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuX6X-00HK8X-Ge
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 10:22:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4119D1F916;
	Fri, 27 May 2022 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1653646920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpiKqWZVtYeezTU24EvdDLlhApiuU/F6GkO8aX8b2Q=;
	b=wiom1hyeLpOv6kzRQwY7O9W5gOAOyaVrzlUS7O21Q2ay+72tEw4Avnkh7xyAUzpyeluq9i
	tn+Epl0tDBH2959w+f5p5UZqeIuJxc94cKjnzwa2FudBTuWNuIkM8qAXpM99Tb8lHZNT9z
	rzhFtwu8bz3edC/iIfs6tt5PJF2wVdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1653646920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QpiKqWZVtYeezTU24EvdDLlhApiuU/F6GkO8aX8b2Q=;
	b=VlZd5+IwT8aoVoVNj+RIs/zj+hUwIQ9xHrSdKgKPiEzHo3g7UDiUCUToWe7yDU52GYhHDI
	vNm7zBVCTzYz1bAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 255E813A84;
	Fri, 27 May 2022 10:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3ypgCEimkGIwawAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 27 May 2022 10:22:00 +0000
Message-ID: <c1114e13-79cd-364c-b9d2-7a149a642919@suse.de>
Date: Fri, 27 May 2022 12:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20220518112234.24264-1-hare@suse.de>
 <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
 <20220526090056.GA27050@lst.de>
 <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de>
 <YpCis+8bv/EJqdlc@gondor.apana.org.au>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <YpCis+8bv/EJqdlc@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_032201_740440_29B6FB28 
X-CRM114-Status: GOOD (  14.42  )
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

On 5/27/22 12:06, Herbert Xu wrote:
> On Fri, May 27, 2022 at 07:50:42AM +0200, Hannes Reinecke wrote:
>> On 5/26/22 11:00, Christoph Hellwig wrote:
>>> On Wed, May 25, 2022 at 11:54:54AM +0200, Hannes Reinecke wrote:
>>>> How do we proceed here?
>>>> This has been lingering for quite some time now, without any real progress.
>>>
>>> As said it is a high priority for the upcoming merge window.  But we
>>> also really need reviews from the crypto maintainers for the crypto
>>> patches, without that I can't merge the series even if I'd like to.
>>
>> Hmm. Guess I can remove those helpers; after all,
>> both are just wrappers around existing exported helpers.
>> I'll resend.
> 
> I've just acked those two patches.
> 
Ah. Thanks for this.

Christoph, you can pick either v12 or v13; the difference is just the 
check for available hash and kpp functions. v12 has the dynamic version
using the crypto helpers, v13 has the static version checking 
compile-time configuration.
Either way would work.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

