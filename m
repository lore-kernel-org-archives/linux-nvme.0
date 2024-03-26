Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30162C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYUWLrhxD42OxDRFZZL0EB01YzO63vj3ZX8e5V6lSJQ=; b=QrcZXRLNt/gmnbcA+mq2EQzKTE
	CpzD9fGMz807crrjaaNtRpHRgWaahcOFAwAC8c+XOZXz+3GBXguURC1NqmRCOA66LpgX3KbeNyJHk
	pTXeIyUifuFTjnA95C5fSOZwjirB/l+lDK0XltN7XZdf7p+9rAor2RrxBVjohhqVa2BLwX0FT74AS
	v+o5d3Uv6/O0lYDU6V0ltn7pQR3tM054wkITtLrCyq5gFIoRmUqCp66enrUBTT1afxQ6pJlJG16hT
	GNWpW3gsiNrMtfmA6wMBDTDuN0tR9H0dZkN9vkpLU1RBO1enf2RSWgHeauM6b3f7UVezWv1S4iFB2
	4zogPrrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp113-00000003P0N-2LbV;
	Tue, 26 Mar 2024 07:14:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp10x-00000003OyL-3CIA
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 07:14:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A4CB34D21;
	Tue, 26 Mar 2024 07:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYUWLrhxD42OxDRFZZL0EB01YzO63vj3ZX8e5V6lSJQ=;
	b=fLu53FCqj+wFiZDYbe4FDQ5wrzaUvEqFQ3eRjgqnjCZ2x6BoM3Tykw6vn8E6YTKY6AJhEK
	yPjrgw8K6ltM5QH68TDfAARxRlTxTSHOEq2aORGtahiXPtwiapgDHBEF/cKROhIOoYdksu
	L3o7Bq9di1q6AcilgIKE92wDlqklFuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYUWLrhxD42OxDRFZZL0EB01YzO63vj3ZX8e5V6lSJQ=;
	b=aswzyIfWCeIhIc/gByW91e+fzEdksztpnHu2IsWAJLxe1UPwgyxoXK5rYWlLTCUy5CoTGV
	5VJ71qXr9fY279Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYUWLrhxD42OxDRFZZL0EB01YzO63vj3ZX8e5V6lSJQ=;
	b=fLu53FCqj+wFiZDYbe4FDQ5wrzaUvEqFQ3eRjgqnjCZ2x6BoM3Tykw6vn8E6YTKY6AJhEK
	yPjrgw8K6ltM5QH68TDfAARxRlTxTSHOEq2aORGtahiXPtwiapgDHBEF/cKROhIOoYdksu
	L3o7Bq9di1q6AcilgIKE92wDlqklFuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYUWLrhxD42OxDRFZZL0EB01YzO63vj3ZX8e5V6lSJQ=;
	b=aswzyIfWCeIhIc/gByW91e+fzEdksztpnHu2IsWAJLxe1UPwgyxoXK5rYWlLTCUy5CoTGV
	5VJ71qXr9fY279Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 547E913306;
	Tue, 26 Mar 2024 07:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1gLeEtV1AmbaTQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 07:14:29 +0000
Message-ID: <b12d233d-8620-4c55-ba94-a4cb3d4a5fbf@suse.de>
Date: Tue, 26 Mar 2024 08:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_001431_974756_FB45C312 
X-CRM114-Status: GOOD (  19.03  )
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

On 3/25/24 19:18, Daniel Wagner wrote:
> On Fri, Mar 22, 2024 at 08:03:26AM +0100, Hannes Reinecke wrote:
>> +static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
>> +				      size_t count, loff_t *ppos)
>> +{
>> +	struct seq_file *m = file->private_data;
>> +	struct nvmet_ctrl *ctrl = m->private;
>> +	char reset[16];
>> +
>> +	if (count >= sizeof(reset))
>> +		return -EINVAL;
>> +	if (copy_from_user(reset, buf, count))
>> +		return -EFAULT;
>> +	if (!memcmp(reset, "fatal", 5))
>> +		nvmet_ctrl_fatal_error(ctrl);
> 
> I'd like to use this also to trigger a reset. This allows to test the
> auth code a bit better, e.g. after changing the ctrl key on the target
> nothing will happen until a reconnect happens. Currently, I have to
> set the max queue count which triggers a reset. Also it would make the
> 'support real hardware' series for blktests why more generic.
> 
> This here should does the trick in my local testing:
> 
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -157,6 +157,8 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
>                  return -EFAULT;
>          if (!memcmp(reset, "fatal", 5))
>                  nvmet_ctrl_fatal_error(ctrl);
> +       else if (!memcmp(reset, "reset", 5))
> +               ctrl->ops->delete_ctrl(ctrl);
>          else
>                  return -EINVAL;
>          return count;
> 

Weelll ... guess what the 'fatal' status does ...
I can rename it to 'reset' if you'd like, but 'fatal' corresponds to one 
of the controller states, whereas 'reset' doesn't.
But I can make it an alias if you really want to write 'reset' :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


