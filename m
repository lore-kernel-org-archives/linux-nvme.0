Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C60DC001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWV3RfP0hrUSuT+rQTv0qiwOZILUNksPQ3sV763KM68=; b=NsIAdnoGPLXHrkEzkVHNbk+lpG
	+YD7jk0e11Dz54ptRhv+izQgRcCvOaWuMdHLTDrbs16kwaIvLfMbfK8yINtH6OE5AeDqPHM6Ta2va
	QwRQs8unJbdZ/3UEsH+ljnQfcPd1Un2g8THJELSPywc+w0KqY6+KieTv0jYHL24IUUKth+Mf9E4dg
	H9UEruqvRyUzt0mbr1aWTfO09DxDz9rCTn6M1c8PG+zCMpwMSXz8thDgPb8LNl+RgRY6nP0TfUZBr
	QrkwSO67QHasHaSdZBSDWQXxI0dCZkQOvgLIDeE5GEUupiCFioTH0OOOZWWni268nOjlL48P+RoMC
	Ex1ErUOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuMT-00GKQW-2x;
	Mon, 07 Aug 2023 07:09:05 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuMO-00GKPw-1i
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:09:01 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3159b524c56so973755f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392133; x=1691996933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWV3RfP0hrUSuT+rQTv0qiwOZILUNksPQ3sV763KM68=;
        b=MoE0ww7kZ3+D4nO9bPBxLJGBEInvtIQnSfGPu6HYq58YifsIj4y68OM2C9L+UH/BcC
         K6yMoi2mnO59bnIZ0+HfiepSS85qphW2+Fgw3/avWQLjlihJ9QLi27z9kfkCxdMbqx8O
         6iW5/vO/F9Q2sJo4BFUjxa8PXPQiSsUi177CvZJLfVjOnfGMinWz30317U1be0uQ6wHX
         3LOe2urgpPyevlRQfR+ySAwZtWyinB7ri45w/YqtmFUZHvn9NtqHAPRRgKWOSnwtD1Lq
         TqOsXWYrYR8MwjDg8duhUFF87UXH19kaD8thXy+h+SC7vPFEZv116cNyhxV9cX5NdF0k
         AXVA==
X-Gm-Message-State: ABy/qLZAf2+h4OK2s0OXWbf9fPxy3ho6FX8CnTjLudwM+BvORNRq1brf
	4484Gf8KdcGfH8BywFPY034=
X-Google-Smtp-Source: APBJJlGpZcydgX6SXxywKayHnJPbGM42xAyFmfoOBPthu8aX/ZBLl806eV2weN4x6XBZ03vt0JkBRg==
X-Received: by 2002:a5d:4443:0:b0:317:3d35:b809 with SMTP id x3-20020a5d4443000000b003173d35b809mr18190349wrr.2.1691392133058;
        Mon, 07 Aug 2023 00:08:53 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm9555878wrr.97.2023.08.07.00.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:08:52 -0700 (PDT)
Message-ID: <5e04afe0-7bf3-1bdf-f4f1-49b0c7bb5dba@grimberg.me>
Date: Mon, 7 Aug 2023 10:08:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230803100809.29864-1-hare@suse.de>
 <20230804175700.1f88604b@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230804175700.1f88604b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_000900_572575_DA95B310 
X-CRM114-Status: GOOD (  19.53  )
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


>> When flushing the backlog after decoding each record in ->read_sock()
>> we may end up with really long records, causing a TCP window full as
>> the TCP window would only be increased again after we process the
>> record. So we should rather process the record first to allow the
>> TCP window to be increased again before flushing the backlog.
> 
>> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
>> -							  decrypted, &flushed_at);
>>   			skb = darg.skb;
>> +			/* TLS 1.3 may have updated the length by more than overhead */
> 
>> +			rxm = strp_msg(skb);
>> +			tlm = tls_msg(skb);
>>   			decrypted += rxm->full_len;
>>   
>>   			tls_rx_rec_done(ctx);
>> @@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>>   			goto read_sock_requeue;
>>   		}
>>   		copied += used;
>> +		/*
>> +		 * flush backlog after processing the TLS record, otherwise we might
>> +		 * end up with really large records and triggering a TCP window full.
>> +		 */
>> +		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
>> +						  copied, &flushed_at);
> 
> I'm surprised moving the flushing out makes a difference.
> rx_list should generally hold at most 1 skb (16kB) unless something
> is PEEKing the data.
> 
> Looking at it closer I think the problem may be calling args to
> tls_read_flush_backlog(). Since we don't know how much data
> reader wants we can't sensibly evaluate the first condition,
> so how would it work if instead of this patch we did:
> 
> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
> +			released = tls_read_flush_backlog(sk, prot, INT_MAX, 0,
> 							  decrypted, &flushed_at);
> 
> That would give us a flush every 128k of data (or every record if
> inq is shorter than 16kB).

What happens if the window is smaller than 128K ? isn't that what
Hannes is trying to solve for?

Hannes, do you have some absolute numbers to how the window behaves?

