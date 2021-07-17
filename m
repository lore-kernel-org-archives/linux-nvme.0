Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7762C636C9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:30:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55219613AF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55219613AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3Iy20YbWPqXSJF5RP/ZSupsd+aeUNSBqWzq6NUuvQw=; b=o1pu8lwI7PVEo6U8fzIXukQjhM
	jH6G/+obkJ2mD22S8fkUjY7PnRY8J/wZElyVvBZFnofH1tNOnoY1aNLJ0j/1NKAZcwax11O9L0uy5
	wxSQQ0w9LhFqo/gstEjkAUpLW1O8rL05GUyessyQTN3zVdOu7chanXAK4beLucva25Vn57UGpimFQ
	J8v2v6HD9IjWP4C6MyBmvLPVagifrf8/3mmkYWo48TWj7q1Cf0BqNvjiBP3rzQcssrKY/eKBdAnYH
	K7YPzXWcgWDbmrg4mly/O4xY0YNT5lN8SLZWaVBMSBhtPyEt7Ygu9oIVM7ofsqAdMTaIuhiWnaT4K
	0EmDvwsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4dq3-006492-MS; Sat, 17 Jul 2021 06:30:15 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4dq0-00648g-Ve
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 06:30:14 +0000
Received: by mail-pf1-f172.google.com with SMTP id u126so3026635pfb.8
 for <linux-nvme@lists.infradead.org>; Fri, 16 Jul 2021 23:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=46YAVZOxsHQqCZvVDcQ2D8oRGYmfN9hSScqkRnqRnqA=;
 b=roKppKS7eb1kVf96raz3pVztCmOQ7Avx8N/75Rd+X4KxZ8gnyizyTuTJGW2/LtY7xW
 LCPvs9DNzVipitTcOBwaoB2XFLVgBGv+z6MXXDvm1O+qHzzMnEgaEA/Vt0YLc2rppcuK
 DktvfAo3ZnVMh5dG86RNGg8ReUlUhgL332TDYJvf9pwwwX4jTwf/44nA7jxmMWy0wKBM
 484IHXk2DnHz6nupIFfOl6cfO3J/3kexxhWyUCG6ImDXamlTMkovUJfpLn7QHYrZb3sC
 pz+OtPYhEXJw0jRVdXl8AgSKklhihGxlbjGSkZ+9W45bEvX3qZCqW7ETip5E+HLtEsXz
 r64Q==
X-Gm-Message-State: AOAM531DYyxhCdN/B4JqIBx4hH4yuzsb7UjBdS31hLaGst7ZIujdgY4W
 xhdCi7MXhFWJnyUu5lDSy2U=
X-Google-Smtp-Source: ABdhPJyJTj5X7ORHeogJQdNIPFfT143p4okpjNN+COImvJwwyQmgK3Ma2alPCBL4Q+SinYH4vJzZog==
X-Received: by 2002:a65:40c3:: with SMTP id u3mr13810419pgp.401.1626503412237; 
 Fri, 16 Jul 2021 23:30:12 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
 by smtp.gmail.com with ESMTPSA id j12sm11721649pfj.208.2021.07.16.23.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 23:30:11 -0700 (PDT)
Subject: Re: [PATCH 05/11] nvme: add definitions for NVMe In-Band
 authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <affd7d4a-6eb5-20b4-fcb3-7e8a0767d7a2@grimberg.me>
Date: Fri, 16 Jul 2021 23:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-6-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_233013_084434_3831737B 
X-CRM114-Status: GOOD (  24.95  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/16/21 4:04 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   include/linux/nvme.h | 185 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 184 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b7c4c4130b65..7b94abacfd08 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -19,6 +19,7 @@
>   #define NVMF_TRSVCID_SIZE	32
>   #define NVMF_TRADDR_SIZE	256
>   #define NVMF_TSAS_SIZE		256
> +#define NVMF_AUTH_HASH_LEN	64
>   
>   #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
>   
> @@ -1263,6 +1264,8 @@ enum nvmf_capsule_command {
>   	nvme_fabrics_type_property_set	= 0x00,
>   	nvme_fabrics_type_connect	= 0x01,
>   	nvme_fabrics_type_property_get	= 0x04,
> +	nvme_fabrics_type_auth_send	= 0x05,
> +	nvme_fabrics_type_auth_receive	= 0x06,
>   };
>   
>   #define nvme_fabrics_type_name(type)   { type, #type }
> @@ -1270,7 +1273,9 @@ enum nvmf_capsule_command {
>   	__print_symbolic(type,						\
>   		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
>   		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
> -		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
> +		nvme_fabrics_type_name(nvme_fabrics_type_property_get), \
> +		nvme_fabrics_type_name(nvme_fabrics_type_auth_send),	\
> +		nvme_fabrics_type_name(nvme_fabrics_type_auth_receive))
>   
>   /*
>    * If not fabrics command, fctype will be ignored.
> @@ -1393,6 +1398,182 @@ struct nvmf_property_get_command {
>   	__u8		resv4[16];
>   };
>   
> +struct nvmf_auth_send_command {
> +	__u8		opcode;
> +	__u8		resv1;
> +	__u16		command_id;
> +	__u8		fctype;
> +	__u8		resv2[19];
> +	union nvme_data_ptr dptr;
> +	__u8		resv3;
> +	__u8		spsp0;
> +	__u8		spsp1;
> +	__u8		secp;
> +	__le32		tl;
> +	__u8		resv4[12];

Isn't that 16 bytes?
You should add these to the compile time checkers
in _nvme_check_size.

> +
> +};
> +
> +struct nvmf_auth_receive_command {
> +	__u8		opcode;
> +	__u8		resv1;
> +	__u16		command_id;
> +	__u8		fctype;
> +	__u8		resv2[19];
> +	union nvme_data_ptr dptr;
> +	__u8		resv3;
> +	__u8		spsp0;
> +	__u8		spsp1;
> +	__u8		secp;
> +	__le32		al;
> +	__u8		resv4[12];
> +};
> +
> +/* Value for secp */
> +enum {
> +	NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER	= 0xe9,
> +};
> +
> +/* Defined value for auth_type */
> +enum {
> +	NVME_AUTH_COMMON_MESSAGES	= 0x00,
> +	NVME_AUTH_DHCHAP_MESSAGES	= 0x01,
> +};
> +
> +/* Defined messages for auth_id */
> +enum {
> +	NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE	= 0x00,
> +	NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE	= 0x01,
> +	NVME_AUTH_DHCHAP_MESSAGE_REPLY		= 0x02,
> +	NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1	= 0x03,
> +	NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2	= 0x04,
> +	NVME_AUTH_DHCHAP_MESSAGE_FAILURE2	= 0xf0,
> +	NVME_AUTH_DHCHAP_MESSAGE_FAILURE1	= 0xf1,
> +};
> +
> +struct nvmf_auth_dhchap_protocol_descriptor {
> +	__u8		authid;
> +	__u8		rsvd;
> +	__u8		halen;
> +	__u8		dhlen;
> +	__u8		idlist[60];
> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_AUTH_ID	= 0x01,
> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_HASH_SHA256	= 0x01,

Maybe s/HASH/HF/ (stands for hash function, which is
a better description).

> +	NVME_AUTH_DHCHAP_HASH_SHA384	= 0x02,
> +	NVME_AUTH_DHCHAP_HASH_SHA512	= 0x03,
> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_DHGROUP_NULL	= 0x00,
> +	NVME_AUTH_DHCHAP_DHGROUP_2048	= 0x01,
> +	NVME_AUTH_DHCHAP_DHGROUP_3072	= 0x02,
> +	NVME_AUTH_DHCHAP_DHGROUP_4096	= 0x03,
> +	NVME_AUTH_DHCHAP_DHGROUP_6144	= 0x04,
> +	NVME_AUTH_DHCHAP_DHGROUP_8192	= 0x05,
> +};
> +
> +union nvmf_auth_protocol {
> +	struct nvmf_auth_dhchap_protocol_descriptor dhchap;
> +};
> +
> +struct nvmf_auth_dhchap_negotiate_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd[2];
> +	__le16		t_id;
> +	__u8		sc_c;
> +	__u8		napd;
> +	union nvmf_auth_protocol auth_protocol[];
> +};
> +
> +struct nvmf_auth_dhchap_challenge_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd1[2];
> +	__le16		t_id;
> +	__u8		hl;
> +	__u8		rsvd2;
> +	__u8		hashid;
> +	__u8		dhgid;
> +	__le16		dhvlen;
> +	__le32		seqnum;
> +	/* 'hl' bytes of challenge value */
> +	__u8		cval[];
> +	/* followed by 'dhvlen' bytes of DH value */
> +};
> +
> +struct nvmf_auth_dhchap_reply_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd1[2];

Maybe __u32 rsvd1? Usually its done this way in the other
headers...

> +	__le16		t_id;
> +	__u8		hl;
> +	__u8		rsvd2;
> +	__u8		cvalid;
> +	__u8		rsvd3;
> +	__le16		dhvlen;
> +	__le32		seqnum;
> +	/* 'hl' bytes of response data */
> +	__u8		rval[];
> +	/* followed by 'hl' bytes of Challenge value */
> +	/* followed by 'dhvlen' bytes of DH value */
> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_RESPONSE_VALID	= (1 << 0),
> +};
> +
> +struct nvmf_auth_dhchap_success1_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd1[2];
> +	__le16		t_id;
> +	__u8		hl;
> +	__u8		rsvd2;
> +	__u8		rvalid;
> +	__u8		rsvd3[7];
> +	/* 'hl' bytes of response value if 'rvalid' is set */
> +	__u8		rval[];

It really sucks that we have zero-length pointers in
a wire-format struct... but anyways, it is what it is...

> +};
> +
> +struct nvmf_auth_dhchap_success2_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd1[2];
> +	__le16		t_id;
> +	__u8		rsvd2[10];
> +};
> +
> +struct nvmf_auth_dhchap_failure_data {
> +	__u8		auth_type;
> +	__u8		auth_id;
> +	__u8		rsvd1[2];
> +	__le16		t_id;
> +	__u8		reason_code;
> +	__u8		reason_code_explanation;

I'd maybe do those shorter;
rescode
rescode_exp

> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED	= 0x01,
> +};
> +
> +enum {
> +	NVME_AUTH_DHCHAP_FAILURE_FAILED			= 0x01,
> +	NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE		= 0x02,
> +	NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH	= 0x03,
> +	NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE		= 0x04,
> +	NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE	= 0x05,
> +	NVME_AUTH_DHCHAP_FAILURE_INVALID_PAYLOAD	= 0x06,
> +	NVME_AUTH_DHCHAP_FAILURE_INVALID_MESSAGE	= 0x07,

I think the language in the spec is "incorrect", why not
stick with that instead of "invalid"?

> +};
> +
> +
>   struct nvme_dbbuf {
>   	__u8			opcode;
>   	__u8			flags;
> @@ -1436,6 +1617,8 @@ struct nvme_command {
>   		struct nvmf_connect_command connect;
>   		struct nvmf_property_set_command prop_set;
>   		struct nvmf_property_get_command prop_get;
> +		struct nvmf_auth_send_command auth_send;
> +		struct nvmf_auth_receive_command auth_receive;
>   		struct nvme_dbbuf dbbuf;
>   		struct nvme_directive_cmd directive;
>   	};
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
