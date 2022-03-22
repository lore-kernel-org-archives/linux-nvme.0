Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6YK+m0gsCWuAoRAiXa3cbZMRJ2+xfYnSRr3ofGooE8=; b=2XYr1OSMv9GdC97yCSxY2Ll23q
	vk1XbSpDwJQcxxPGwlMrCf4iZI9fp8QhZ6sasU9BIHH2MuayXZczYsOPchCZWtm2r7ndrmu8hMCGd
	eo4LmKPOc/PPCWQk4v3y/DwtDV0G/f62L8bzzU1hTUIjU3QrwA+hWzm5V9DygR0Q78JhUTI0+TCE6
	keSrXEb+9Tk0DfNmDQFW+UZeMofhccA9zSkT3zqSkL8lIwPIgFHBfK+norbxnCSIWW/ZvlNVPkiSe
	/sRgV/wiAqgdmxBYwcjo9wFizjg2pvB0B4N0oyOihK8Wnsva7swBG6hDnFgddqpXyKut7MEjx8zJ9
	Y1zckYzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWdLk-00Av1k-Kr; Tue, 22 Mar 2022 12:10:56 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWdLh-00Av0p-Cy
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 12:10:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D6141F38A;
 Tue, 22 Mar 2022 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647951050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6YK+m0gsCWuAoRAiXa3cbZMRJ2+xfYnSRr3ofGooE8=;
 b=ISU1wmpDwFVkPVC1OhIgDheruEQMNYjsiCb9wzGlTpOVKRaP1UXNS8BU5n7++Qixe4L/dX
 2Nryeya3YNKSp2vbj04GiXB+Y98JmG2EhBPgRJzS41kj6/8DkyY3cRlsAQf79NKObVsVlp
 2sC8rQbEJg8Oq09GIQ5sWIo2dGqFl6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647951050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6YK+m0gsCWuAoRAiXa3cbZMRJ2+xfYnSRr3ofGooE8=;
 b=pAmkroSjXLFPYJekFbk8BDdBgh8azi/riV6Jn0kLbL6Boe38LXjXKrjFtJL3tBdQqipBhL
 eQM4wOtVppsm7nDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B7A712FC5;
 Tue, 22 Mar 2022 12:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OqsTEsq8OWL5XQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 22 Mar 2022 12:10:50 +0000
Message-ID: <3382242d-7349-e6f9-9b3c-4a5162f630c0@suse.de>
Date: Tue, 22 Mar 2022 13:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211202152358.60116-8-hare@suse.de>
 <346e03e9-ece1-73f9-f7f4-c987055c5b9f@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <346e03e9-ece1-73f9-f7f4-c987055c5b9f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_051053_626559_A3B319A3 
X-CRM114-Status: GOOD (  16.04  )
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

On 3/22/22 12:40, Max Gurtovoy wrote:
> Hi Hannes,
> 
> On 12/2/2021 5:23 PM, Hannes Reinecke wrote:
>> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
>> This patch adds two new fabric options 'dhchap_secret' to specify the
>> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
>> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
>> the pre-shared controller key for bi-directional authentication of both
>> the host and the controller.
>> Re-authentication can be triggered by writing the PSK into the new
>> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.
> 
> Can you please add to commit log an example of the process ?
> 
>  From target configuration through the 'nvme connect' cmd.
> 
> 

Please check:

https://github.com/hreinecke/blktests/tree/auth.v3

That contains the blktest scripts I'm using to validate the implementation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

