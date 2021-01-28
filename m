Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:34:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3154564DFA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3154564DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zECumaAy3zNb045BpxqbIniwJxKwQfinCoTS6arUVsg=; b=PqRo68L5Md20T48JOAK1Qy0ig
	vHqJbsenVPbJ4ki6clPpK3jk62zEWPh9baDgyPf0Du2IOkjbCHOo4c4fhpzv3NX8JIspDxaSi7Nk4
	hZJ8d4eDOp2eu2BibOOaXKp/Xmeiqn+GkneEZRuGi5uXBjTWMFSxI8UZA6J2MpYaMk3ZCDlfdz150
	pr/7eAXueK6WlhgSYPq3luyJXwbD6tz3gHJTv5ze900AiyP6VNMpdDy4O+e2F5S0Eg93+UL5kEtDY
	wm1rk9htWhpUgoUn/NcisI8D5Ioeeyx2yjuoVWt1e3LwD4IxxeZOIlM1zAm5DaI7y8lDYKjQvm0tA
	++jol5pcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5GnT-0000Yv-Mv; Thu, 28 Jan 2021 23:33:55 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5GnQ-0000YI-LT
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 23:33:54 +0000
Received: by mail-wm1-f53.google.com with SMTP id c127so5835759wmf.5
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 15:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jv2lvoFK7OXHTZIcbJ1l2aj7s3HkfGFuMlmAk7u2AOI=;
 b=B6vFPdWOIaoWF0HmlBIM6LvvQJPiBX3yyw7fYDuv3RlMp87XzMQXr1Ey0oqIQQHiRZ
 N9WCnM9qzYwIP499Wd1ZyhczNAY3JM4g2uquiQ+EDX9rw7sB0DH/eMpAZa8H208fDYda
 OYIgU3UPJ0wvSx/ZpYPzykR7HUIW/EWhWEt3LeJlo31XMqc2pIiVIJ8zrLc7TxN+T1zV
 OWMcdPoB5G8GRnW+uL5pZnjrv6EQRHZU/EyUXDucFV6bwAVDID3AqstWwojx/+UifLyV
 HnjG591+N7Df0mGvKAIhI0FWsHkNQWegHhA0pesIc1hdreaZ+h/meCFdejg5DMCV1beJ
 oJrg==
X-Gm-Message-State: AOAM533beeww3mNlc7nELmkUHHtcVvNOrOFe7cHgjR4+watPXPyDBCdt
 mBY7PuHAmX8RRNzIQZMuUZMtRzfBG/M=
X-Google-Smtp-Source: ABdhPJxJDVpBqKrP+J63nQwOroGrk0M+Sh2cu/JbLIWVOYkGVBksQvVcxm4+DidNjnBAQzCpgHQElg==
X-Received: by 2002:a1c:620a:: with SMTP id w10mr1226921wmb.167.1611876830502; 
 Thu, 28 Jan 2021 15:33:50 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id l10sm8936228wro.4.2021.01.28.15.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 15:33:49 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
Date: Thu, 28 Jan 2021 15:33:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_183352_717194_24AC83A1 
X-CRM114-Status: GOOD (  17.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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


> That will work if sk_state_change is called under sk_callback_lock.

It is.

> In addition, need to flush_work(&queue->port->accept_work) in nvmet_tcp_release_queue_work because accept_work is still using queue struct after unlocking sk_callback_lock.


But sk->sk_user_data was not set, so I don't see how the release work
can invoke.

> What about this instead?
> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index c41902f7ce39..6388d18ca7c2 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1494,16 +1494,28 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>                   ip_sock_set_tos(sock->sk, inet->rcv_tos);
> 
>           write_lock_bh(&sock->sk->sk_callback_lock);
> -       sock->sk->sk_user_data = queue;
> -       queue->data_ready = sock->sk->sk_data_ready;
> -       sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> -       queue->state_change = sock->sk->sk_state_change;
> -       sock->sk->sk_state_change = nvmet_tcp_state_change;
> -       queue->write_space = sock->sk->sk_write_space;
> -       sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       switch (sk->sk_state) {
> +       case TCP_FIN_WAIT1:
> +       case TCP_CLOSE_WAIT:
> +       case TCP_CLOSE:
> +               /*
> +                * If the socket is already closing, don't even start
> +                * consuming it
> +                */
> +               ret = -ENOTCONN;
> +               break;
> +       default:
> +               sock->sk->sk_user_data = queue;
> +               queue->data_ready = sock->sk->sk_data_ready;
> +               sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> +               queue->state_change = sock->sk->sk_state_change;
> +               sock->sk->sk_state_change = nvmet_tcp_state_change;
> +               queue->write_space = sock->sk->sk_write_space;
> +               sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       }
>           write_unlock_bh(&sock->sk->sk_callback_lock);
> 
> -       return 0;
> +       return ret;
>    }
> --
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
