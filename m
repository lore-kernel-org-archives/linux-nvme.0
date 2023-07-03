Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C45EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWiOceW7KqbkNyujHgyhzAZpGdRt7L23CzgnF5NGVbo=; b=AcG/4Sb4Nc8aGi501NZhJYE4yz
	McHJFdgnZE7zGKB0NoCSj2HEzAHoYnB4TrxeVSOG/Dca32fBjQ0MdZtyqnKj+0s4Ylun9tqjhcwJy
	uyTPsLSdLbpxAaMK094YRWeKB0EN6w26N9UG/AavFfVadJk5mZOvOKvjeaOhTbJn8P5XcitnwWucp
	c5hm4PyiRiMrCdgx7j3BUyNAFrispSYeAzmAlzuoEYX4V77oHokc9y1XHmykxP4+6+Rg1pUBNqA7y
	I7OG6yTJfwpDvvgy0OW36UezkS81fSQVjcR0N+7ExGNR2oLwB7/3IeuOcFjrapFHNkkcHFK30H9sF
	rvw/MKZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFW3-009rUO-1T;
	Mon, 03 Jul 2023 09:06:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFW1-009rSh-0m
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:06:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D77FF218F1;
	Mon,  3 Jul 2023 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWiOceW7KqbkNyujHgyhzAZpGdRt7L23CzgnF5NGVbo=;
	b=hIUBfL9NsE09nvg4kt+xxtAJ1aSdDlYSylQzRyYGKjKRzzJQqGCIHyc8Ud9YyWp2m7gWfZ
	QADkE+U/hjoJPpP6oZoP1V9O/JIGUDrE5r9QXg3bmzoRKEEcYGzAjTxLELTnmYDo/dgocC
	iJ6U5Y9eQGw1cqm2RBDa4s3EksTH0EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWiOceW7KqbkNyujHgyhzAZpGdRt7L23CzgnF5NGVbo=;
	b=myAQRBOCFCuceyZA6d42UPbtvcYVXr+Jo1/Yq8vKf3KXFZr316t8/OBybRiXpYMuLhmumN
	YbMXYQk1hpywe4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8BFD13276;
	Mon,  3 Jul 2023 09:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ztVYMJuPomQpCQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 09:06:35 +0000
Message-ID: <68c5be4d-3eed-cfc7-901a-59a9cd1bd4cd@suse.de>
Date: Mon, 3 Jul 2023 11:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: nvme in-band authentication blktests - nvme/043
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "alan.adamson@oracle.com" <alan.adamson@oracle.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <eedfab08-e50c-0a51-5dd3-2861dcc02b4d@oracle.com>
 <bu5hjttqtlxm4dqs2zfacsmrargz7kxpawkh2kfgitihlibk2a@356kctyedf6i>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bu5hjttqtlxm4dqs2zfacsmrargz7kxpawkh2kfgitihlibk2a@356kctyedf6i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_020637_420913_8D24FB6E 
X-CRM114-Status: GOOD (  11.79  )
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

On 7/3/23 08:46, Shinichiro Kawasaki wrote:
> CC+: Hannes,
> 
> On Jun 29, 2023 / 12:24, alan.adamson@oracle.com wrote:
>> I'm playing around with in-band authentication and using blktests to see how
>> to setup it up and use it.  In test nvme/043, a valid hostkey is never
>> initialized and a NULL is being used to setup the target and to connect.  Is
>> this expected?  The test with the NULL hostkey passes.  I updated the test
>> to use a valid key and it also passes.
>>
>>
>> diff --git a/tests/nvme/043 b/tests/nvme/043
>> index a030884..d5e0d4b 100755
>> --- a/tests/nvme/043
>> +++ b/tests/nvme/043
>> @@ -40,6 +40,8 @@ test() {
>>          fi
>>          hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>>
>> +       hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>> +
>>          _setup_nvmet
>>
>>          truncate -s "${nvme_img_size}" "${file_path}"
>>
> 
> Alan's question looks valid for me.
> 
> Hannes, may I ask your comment?

Yeah, that's correct.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


