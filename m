Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6CFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfuXzQ6r9vXgo3WfQ3hcxMh4FVhx0Qv2YApJrnlRp9k=; b=dA1T9qDqmuaTY5+99KfzT1uz+X
	ZlqAjTvQKCpBg0AusxwfEJGjwU1QkqI2W/bABye6BvwvrdnPYn4wFba/+IhQeIsA95x/7lieavw5L
	Ll0VVR8dSXtqIX14ZuNiAij8sRaxHOc8JnZNdh6jyHR6bO2bR7bU+VRCvzRFzWsMkpQJZScpoWjTZ
	7aRJxNK1DivQ2B0oHNvImMgzjKx3Fueq9vTv12g6Hqpqxbxf8ga8QgxnmNr971nMvXR3E5wmAsXTg
	Rl4Cg9eDEpBSzXCMrQiPvbuuXSSIwN6t6SmZAuTu9aOu/NQGLkgziL5DAcj8HU4pYhjGiobAPPv2o
	YkLX5VWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbch1-00HJDN-UU; Tue, 05 Apr 2022 06:29:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcgz-00HJCY-UB
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:29:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 553521F38A;
 Tue,  5 Apr 2022 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649140168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfuXzQ6r9vXgo3WfQ3hcxMh4FVhx0Qv2YApJrnlRp9k=;
 b=CIZEvPgx7vPqovnit0pxwpS/Xw26+1TejYa83g9i/CmZZ5gNurxHu37JeIYMtEajUaN/W3
 Hd746FCg6oJk0YgJY4JjevUCxEDwPMU7SOboN7nOCDkp6bNWcHuhhFNeomL09GgxIvZ55k
 jZg2VENrUW3VioWhQppTwk1Z4njLzxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649140168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfuXzQ6r9vXgo3WfQ3hcxMh4FVhx0Qv2YApJrnlRp9k=;
 b=yjBBcuIF5GyFx8Iwk34g/H7a7KakEd7Y6/LlUak7Gy1P0iNBtUBUlyN/ynWWql2wL/uRNr
 1t1TWvvmyshYR2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B8E613A30;
 Tue,  5 Apr 2022 06:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dxmwDcjhS2LjVwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 06:29:28 +0000
Message-ID: <66428672-250b-950e-ab7c-0a6ceb10c06e@suse.de>
Date: Tue, 5 Apr 2022 08:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
 <20220405060946.GB24073@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405060946.GB24073@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_232930_159629_6651D868 
X-CRM114-Status: GOOD (  14.34  )
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

On 4/5/22 08:09, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 08:00:25AM +0200, Hannes Reinecke wrote:
>> I actually looked into that with my previous attempt, and really found no
>> good way of having an entry which is
>> a) pre-filled
>> and
>> b) removable by the admin later on.
>>  From what I've seen all pre-filled entries are static; I haven't found a
>> way to do pre-filled dynamic entries.
> 
> I don't think we need to remove the well known discovery subsystem. But
> we can allow removing all entries from it and thus reporting an empty
> log.

Hmm.
We still would need to pre-fill these entries when creating subsystems.
Bringing us back to square one, namely there is no way to create dynamic 
pre-filled entries.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

