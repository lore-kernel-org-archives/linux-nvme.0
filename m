Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2580CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnluNFbmab5ay4tuYvNxqBLAyNMV6NJXc75I3P7Oxok=; b=c+mFkGnUp58Nchw3kO2W02rbVQ
	N3Sq4PjAXsC23v+vtVk+njQP41ldWwwoqc7TpdoXluSU7fofC+wGOB/cnU9Delr7pgyCZoE23vlzT
	YeO2nKYJvM8Yk0rfARcrbbuVFLipirUPeSlZb6tv0rV0J48Vd3pZ+BMI/5kgx+LyIlgPoDDzkIGfG
	lfH7d4b7+mCwQRkSa32hy3D52QnYg54X+3gkIuniU96mBN92XmNOaSoFMnkN+FfiHEquYpGrFTM3D
	+y9WAKhSO4gPszgarmRvknhidiusqsXH4VjsZZX94fRag8w5L7YthcqNE309Myc2C+SfucdP7q3VX
	sSQAZ1KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJNX-008uGU-2p;
	Mon, 16 Oct 2023 08:55:11 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJNV-008uEZ-04
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 08:55:10 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 324F7240101
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 10:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697446503; bh=lcNO8RF8USGnm28CYJPW25RzcPZaulI87Ufu5MZHyDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
	 Content-Transfer-Encoding:From;
	b=ZuMb11FjDdRmUE0axVeJ4HLJ3ZQbvSswZremwJ03NnMz84KR75watyOali/Lf6fXT
	 rNrxxhYt4IWFhHoQ2775EXnmWTgwY6xJjdoDEbP7Ab6Es6e5R7yZRWllkxU+6HHl+R
	 MTIoaHXuevY5OA38mG9VpVNkW3b10VB/ZoccpuZS+V6R2vM5kHAvww7mL5Vq8utmDx
	 liP9iUveXXtx8KxrGRj2XDpubImQgma5dVUuKjirlqsPMiNCH4iN34+UhARnEPvTqA
	 +W1LaRGrhMO6/R38KACq91VBGn7bOqrTtvf6YGgXFtI+HbM28c55gQquk6gJCDXYcv
	 CKz8r1H0FL3Nw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S89st09KMz9rxY;
	Mon, 16 Oct 2023 10:54:57 +0200 (CEST)
Message-ID: <7e3e0394-c644-4f7c-b7c8-849d459b3931@posteo.net>
Date: Mon, 16 Oct 2023 08:54:57 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] nvme-auth: use transformed key size to create resp
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org, Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231013202827.2262708-1-shiftee@posteo.net>
 <20231013202827.2262708-2-shiftee@posteo.net>
 <c60d34b1-5e2f-4b32-8519-c4a4ff89060a@suse.de>
From: Mark O'Donovan <shiftee@posteo.net>
In-Reply-To: <c60d34b1-5e2f-4b32-8519-c4a4ff89060a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_015509_200996_90FDEABA 
X-CRM114-Status: GOOD (  17.39  )
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

On 14/10/2023 12:41, Hannes Reinecke wrote:
> On 10/13/23 22:28, Mark O'Donovan wrote:
>> This does not change current behaviour as the driver currently
>> verifies that the secret size is the same size as the length of
>> the transformation hash.
>>
>> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
>> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>> ---
>>   drivers/nvme/host/auth.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index daf5d144a8ea..e7d478d17b06 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -418,6 +418,14 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
>>       return size;
>>   }
>> +static int nvme_auth_dhchap_transformed_key_len(struct nvme_dhchap_key *key)
>> +{
>> +    if (key->hash)
>> +        return nvme_auth_hmac_hash_len(key->hash);
>> +
>> +    return key->len;
>> +}
>> +
>>   static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>>           struct nvme_dhchap_queue_context *chap)
>>   {
>> @@ -442,7 +450,8 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>>       }
>>       ret = crypto_shash_setkey(chap->shash_tfm,
>> -            chap->host_response, ctrl->host_key->len);
>> +            chap->host_response,
>> +            nvme_auth_dhchap_transformed_key_len(ctrl->host_key));
>>       if (ret) {
>>           dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>>                chap->qid, ret);
> 
> Hmm. Yeah, hash size vs secret size always gets me.
> However, wouldn't it be better to return the key size from
> nvme_auth_transform_key and us that directly?
> (cf the attached patch)
> 
> Cheers,
> 
> Hannes

Hi Hannes,

I gave this a try and it ended up being easier to put it in struct nvme_dhchap_key.
V2 also does the nvme target code, and this means the length is stored in the same place.
Let me know if this works for you.

Thanks,
Mark

