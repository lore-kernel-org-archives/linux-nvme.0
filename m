Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E616AC761AF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lg25NWhnMP0gaisU2D0nCzZLd/UJpiz05GklhhcuxXE=; b=kKi9nGl3PmwhSC4kQ5OxZQFVl6
	uq/kjOegq3cj1V9hZxEazELGd2CuG1jV4P+otunmNisUaeP1nHIb8fBsvZ+v31l6agA9D+oK6Mlj6
	8uFk+lizsATsK1itVvPK8isRPWAg4jdKFtlH8BPSVaN0nuVj1Ufr9zbTrTsVunSapu2gTo0Cxq0Ms
	b3n0FeW5Oi36bccZ/g7Ht9ThAT3iRCkGN1Wj/olWZSGLTe2hrjIIv4A+UfkVlvk5vNIADHgH4ppev
	v6sVvPmC9JYo3dNAnZNQLBiNGkInPmmS1lbKblmMOM6AAdmnisTG/COJ6NeRM2pRtZn5N5FFHEBh2
	O29NmgOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phrsl-003ocg-1h;
	Thu, 30 Mar 2023 12:59:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phrsi-003oaW-1K
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 12:59:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0C11F37E;
	Thu, 30 Mar 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680181191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg25NWhnMP0gaisU2D0nCzZLd/UJpiz05GklhhcuxXE=;
	b=l5ZJ2+6JeSj/iiqEeaRLqeDnaWCfGv88hBpTCRZ7S1PpX4UGmZTa4mwtuNkzlB17wWoUbo
	44NLrqwP7d8qxssf+5mlgIDJD2CILVguVXq4+f0mNRKKzsP9zUqapeWI/wR7xn81oBwo+4
	7b+UQGmlB/xc+f/I9C0ubG9m/XCtft8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680181191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg25NWhnMP0gaisU2D0nCzZLd/UJpiz05GklhhcuxXE=;
	b=ABLNih4ozBJ8NTfm3YwkiSsQu0Yq+dlimFWuHlgfEMcs3MmxRs1Mxj41woThi+U1GpgDP6
	086QcSMy1LlTpADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6171348E;
	Thu, 30 Mar 2023 12:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id x8qNHceHJWRQeAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 30 Mar 2023 12:59:51 +0000
Message-ID: <8b4125d6-62f0-8416-f11d-9b5f3f58c70b@suse.de>
Date: Thu, 30 Mar 2023 14:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-10-hare@suse.de>
 <20230330125424.q65gcbu7rrmnmueb@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230330125424.q65gcbu7rrmnmueb@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_055956_601787_6820F039 
X-CRM114-Status: GOOD (  13.47  )
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

On 3/30/23 14:54, Daniel Wagner wrote:
> On Wed, Mar 29, 2023 at 03:59:29PM +0200, Hannes Reinecke wrote:
>   --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>>   	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
>> +	{ NVMF_OPT_TLS,			"tls"			},
>>   	{ NVMF_OPT_ERR,			NULL			}
>>   };
> 
> This should be ifdef out for !CONFIG_NVME_TLS

No, I did that on purpose.
Error handling in the fabrics option parsing is notoriously bad, and if 
we disable that nvme-cli will fail with annoying interfaces.
As it stands, the 'tls' option will be accepted, but you'll get a kernel 
message telling you it's not compiled in, and the function returns -EINVAL.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


