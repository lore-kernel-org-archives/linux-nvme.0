Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06237C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbKU2OF86UPuVPELt9TcC5rsAyYqeClUEknxePZcRvA=; b=NjdP+yEeyDMS7q+OdeEQFiwkxn
	sXWjv3a1bK7GLMEmMRO4VY0DIe3lPD3OGs4SrY/Sts3yWMLmZXU/DWEDnIn4C3lbcvsgXOun53aEP
	K2fVkgZyXGFIYNvOBffwciaexUGLuvLyYLGZO/3atKLaXFMD+AviXCDTkCn41jFbhRD3U+9BtbIgZ
	ffrv4UPst6AcBtVeDUtAP5Z/25XPZl7mIvjJwPbxHZ7TV9kXkyoUxlVQMNs09soo0yEXjr7D7Ptyi
	qHbXl6mvAFkLMe370JdOrTfKFIcLAANdueJwygoZ4gBC35K0Jc2fEYgkeXv4OdedXkH1Or0uPaPh5
	8dYsnY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrvnj-00Ai7c-8X; Fri, 20 May 2022 06:07:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvnf-00Ai6U-KL
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 06:07:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B37C91F9A9;
 Fri, 20 May 2022 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653026863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbKU2OF86UPuVPELt9TcC5rsAyYqeClUEknxePZcRvA=;
 b=ZpBMRUdr/yxOmFNCLp5Cedao9AryRJlxOAW9rhXNtqV21q5N80Ewf13/J5fkHHcIkTRmNQ
 nztYY+PrtIvZA+yvGWum/gBpHLMPFYtFThJhnmjkibX03qulL/RLEsp8GUIleR8lJrVTIe
 oQTrXowvogaNim1vWEmxiqB0OCASkpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653026863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbKU2OF86UPuVPELt9TcC5rsAyYqeClUEknxePZcRvA=;
 b=egdV9BOdadegD0puQdNh36WsxV7caaZDO9UqLzNLxBMlJuan3AaikX0x9GqZu4H7sEHyuS
 xZU3HZ7ChexSXiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C49D13A5F;
 Fri, 20 May 2022 06:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QUrNEC8wh2KlEAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 20 May 2022 06:07:43 +0000
Message-ID: <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
Date: Fri, 20 May 2022 08:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_230747_857111_3ABF032A 
X-CRM114-Status: GOOD (  17.29  )
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

On 5/19/22 20:47, Damien Le Moal wrote:
> On 5/19/22 16:34, Johannes Thumshirn wrote:
>> On 19/05/2022 05:19, Damien Le Moal wrote:
>>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>>>>> I'm a little surprised about all this activity.
>>>>>>>
>>>>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>>>>> is very little benefit in supporting this scheme.  It will massively
>>>>>>> fragment the supported based of devices and applications, while only
>>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>>
>>>>>> FWIW,
>>>>>>
>>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>>> videos become available, folks can decide for themselves.
>>>>>
>>>>> There was no real discussion about zone size constraint on the zone
>>>>> storage BoF. Many discussions happened in the hallway track though.
>>>>
>>>> Right so no direct clear blockers mentioned at all during the BoF.
>>>
>>> Nor any clear OK.
>>
>> So what about creating a device-mapper target, that's taking npo2 drives and
>> makes them po2 drives for the FS layers? It will be very similar code to
>> dm-linear.
> 
> +1
> 
> This will simplify the support for FSes, at least for the initial drop (if
> accepted).
> 
> And more importantly, this will also allow addressing any potential
> problem with user space breaking because of the non power of 2 zone size.
> 
Seconded (or maybe thirded).

The changes to support npo2 in the block layer are pretty simple, and 
really I don't have an issue with those.
Then adding a device-mapper target transforming npo2 drives in po2 block 
devices should be pretty trivial.

And once that is in you can start arguing with the the FS folks on 
whether to implement it natively.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

