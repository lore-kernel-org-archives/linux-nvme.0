Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264FBC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+q5cc+bbEqJb/cCk3yPQ/KRaFtPGduOhc/OQGTeiqgM=; b=GJIBtIOFG10Ecb5UwiabZspoCd
	qKlUL5QaNi9KMcVsk/b0hbuxgjughvaRUiDQ6CcobG6Jcq5eI1aJVzi1+QBubplka1T7CDGgCUti8
	gGCq6rOuH6BOfzMTiMkq30t10eB3Egy0ixFAMGKJ7Tc3/ZbXjc6yiA/bSfaAcxISgRnF41Ri8hGvm
	Fxgjzc+uGUQhroqDE4xaiABu9sFRNenbu7a5ajDCDyuVSNdbOPJQAzqkmCLAqzYwjapHH2I0cU5wI
	RXy78Jg9bRDzwODgLnshL1cmiCBHfkjV3AA2Z3iiQKSZri31WkRzfA9ZiuukdyHybquCi4y47aReo
	6SSFkrTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qQN-001YzZ-Eb; Mon, 27 Jun 2022 15:13:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qQJ-001Yx0-SH
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 15:13:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1846E1FA63;
	Mon, 27 Jun 2022 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656342788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+q5cc+bbEqJb/cCk3yPQ/KRaFtPGduOhc/OQGTeiqgM=;
	b=O83I4yNPN4RHEsPktNtiNANZo0CLLfA6L+d39p4U3YVH3cztRASqj3FYnBE4/F1fYBwKa0
	vFgy0s3aNbyjDdKHdXWhZNGLchPdfs44gSFbw98j9mciNFOZtg+qQsiq+CsuNBrzSw995Q
	/fnCEDOpwWbjt/21aXi1CFGEF0WBvkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656342788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+q5cc+bbEqJb/cCk3yPQ/KRaFtPGduOhc/OQGTeiqgM=;
	b=411io4VNDRc6Ij7D9l1tYjWhlYcs4bcF6YPhspVlxjeXqSCgfnpTM+uo3fSIbBZtRGCINi
	e6jua+B0ydZY/GAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAD3E13AB2;
	Mon, 27 Jun 2022 15:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id h2BoOAPJuWKxUAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 27 Jun 2022 15:13:07 +0000
Message-ID: <f6026926-79e6-3376-edf1-ce15f91b73cc@suse.de>
Date: Mon, 27 Jun 2022 17:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvmetcli: support 'dhchap' attribute group
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220323073316.15862-1-hare@suse.de>
 <1bce9221-61e7-fd6d-198f-c77ba2e5e58b@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1bce9221-61e7-fd6d-198f-c77ba2e5e58b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_081312_146925_D9571DED 
X-CRM114-Status: GOOD (  18.87  )
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

On 6/27/22 17:08, Sagi Grimberg wrote:
> 
>> NVMe authentication support added a new attribute group 'dhchap'
>> to the host configfs directories. This patch adds functions to
>> display and modify these entries from nvmetcli.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   nvmet/nvme.py | 2 ++
>>   nvmetcli      | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
>> index d170204..2ad9006 100644
>> --- a/nvmet/nvme.py
>> +++ b/nvmet/nvme.py
>> @@ -892,6 +892,7 @@ class Host(CFSNode):
>>           '''
>>           super(Host, self).__init__()
>> +        self.attr_groups = ['dhchap']
>>           self.nqn = nqn
>>           self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
>>           self._create_in_cfs(mode)
>> @@ -913,6 +914,7 @@ class Host(CFSNode):
>>           except CFSError as e:
>>               err_func("Could not create Host object: %s" % e)
>>               return
>> +        h._setup_attrs(t, err_func)
>>       def dump(self):
>>           d = super(Host, self).dump()
>> diff --git a/nvmetcli b/nvmetcli
>> index 8ee8590..8da379b 100755
>> --- a/nvmetcli
>> +++ b/nvmetcli
>> @@ -661,6 +661,10 @@ class UIHostNode(UINode):
>>       def __init__(self, parent, cfnode):
>>           UINode.__init__(self, cfnode.nqn, parent, cfnode)
>> +    def summary(self):
>> +        info = []
>> +        info.append("key=" + self.cfnode.get_attr("dhchap", "key"))
>> +        return (", ".join(info), True)
> 
> 
> We shouldn't have a UI to the secrets themselves I think, we probably
> should do this instead:
> diff --git a/nvmetcli b/nvmetcli
> index 8da379bde9db..b06039b2338d 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -663,7 +663,14 @@ class UIHostNode(UINode):
> 
>       def summary(self):
>           info = []
> -        info.append("key=" + self.cfnode.get_attr("dhchap", "key"))
> +        if self.cfnode.get_attr("dhchap", "key"):
> +            info.append("hostkey=set")
> +        else:
> +            info.append("hostkey=unset")
> +        if self.cfnode.get_attr("dhchap", "ctrl_key"):
> +            info.append("ctrlkey=set")
> +        else:
> +            info.append("ctrlkey=unset")
>           return (", ".join(info), True)
> 
>   def usage():

Or just append 'hostkey' and/or 'ctrlkey' if set, and register nothing 
if the keys are unset.

Good point, though. I'll be sending a new patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

