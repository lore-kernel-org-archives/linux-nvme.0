Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E6CCA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jIp30WWagQcq95vAHZsEIV4haOheDDmffUDTljoxLrw=; b=WABE7mMg6sD3CRn+ifdcwLKlsB
	39NaEXGlPoE+SucHXcobKpa2CUmbNTL3tI8dk1YrU4QWfUQ4N6yfCG71gfVyIUlzBT3s7lfsKCd5K
	iF+zmykLdAFGhX1yi4GlkaEQxGqEphKI1y0HvCwKm9CgDhrFVrDZkuSsJhE9AH7y3YZjT3IvGn6Ob
	8GXSQi8G0attQUmj/Oz+AwC/MeQc0laxex95MrDL7GbV3dx6595SN2Z1ZOV4b8Uqk0pPr1XzrgShz
	l4qfVw6j4wGBtjpjOUq52WHialoc+7PtdaBEsZlCXZsiSU1OiuStKWOHe66try7eMxLreC0J8I80f
	YY7Y+r+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1fC-003DcD-1i;
	Tue, 12 Sep 2023 11:34:38 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1f6-003Dap-2N
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:34:36 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1122310a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518469; x=1695123269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIp30WWagQcq95vAHZsEIV4haOheDDmffUDTljoxLrw=;
        b=pef6rHhO/RDIFlvZpWnX5FhwB5kAyXa91Ee1bSRKDIQQ3Ea7Vap+Jwkbyciu+wOSHN
         hQ+glbleY8Pc0+4+QE3SOhfriBcopPQC3a1w7G3D3QNs9bNnC+mRLLTqQ/hu+e+wwJA0
         grKJnehK1PlY3bCoTbVkwcExKjHoRn4eYXAdzEKgEiNvBoLhJhFBEq7kWo7xUZTFsCcH
         vrMw78Q4GymlJTgJCM31FaPFKlhvOqchhNxaM2M8Y+2WEpQZG/zNQx63hUxOz3JmO7YW
         xOrr4JXH2gW5p0Y05DkaIk4Hpi6nhGfCAg3k8nOR0ss4YG7VgfCzsZJJYvjC940Aw+lQ
         mS+Q==
X-Gm-Message-State: AOJu0YzZ9Sc9YDt7MXHhMRYFurhbbk7ACyG4kXUIevSt2L0GrUYkX0sm
	2WgJ4CZxQcSobD4+burrAAM=
X-Google-Smtp-Source: AGHT+IFlhD/vIyJaOoaiePPfWJM32l6QfjzD75VpAA5V4DZLSu/7wGUbWZtrDjtlCl03p2LHT/kXSA==
X-Received: by 2002:a17:907:971d:b0:9ad:786d:72af with SMTP id jg29-20020a170907971d00b009ad786d72afmr2251349ejc.5.1694518469001;
        Tue, 12 Sep 2023 04:34:29 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lc18-20020a170906f91200b0099329b3ab67sm6744347ejb.71.2023.09.12.04.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:34:27 -0700 (PDT)
Message-ID: <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
Date: Tue, 12 Sep 2023 14:34:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_043432_773138_22D86219 
X-CRM114-Status: GOOD (  40.06  )
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


> Hi all,

Hannes, I think that this is in decent shape. Assuming that
the recent reports on the tls tests are resolved, I think this
is ready for inclusion.

I also want to give it some time on the nvme tree.

> 
> with the merge of Chuck Levers handshake upcall mechanism and
> my tls_read_sock() implementation finally merged with net-next
> it's now time to restart on the actual issue, namely implementing
> in-kernel TLS support for nvme-tcp.
> 
> The patchset is based on the recent net-next git tree;
> everything after commit ba4a734e1aa0 ("net/tls: avoid TCP window
> full during ->read_sock()") should work.
> You might want to add the patch
> 'nvmet-tcp: use 'spin_lock_bh' for state_lock()'
> before applying this patchset; otherwise results might be ...
> interesting.
> 
> It also requires the 'tlshd' userspace daemon
> (https://github.com/oracle/ktls-utils)
> for the actual TLS handshake.
> Changes for nvme-cli are already included in the upstream repository.
> 
> Theory of operation:
> A dedicated '.nvme' keyring is created to hold the pre-shared keys (PSKs)
> for the TLS handshake. Keys will have to be provisioned before TLS handshake
> is attempted; that can be done with the 'nvme gen-tls-key' command for nvme-cli
> (patches are already merged upstream).
> After connection to the remote TCP port the client side will use the
> 'best' PSK (as inferred from the NVMe TCP spec) or the PSK specified
> by the '--tls_key' option to nvme-cli and call the TLS userspace daemon
> to initiate a TLS handshake.
> The server side will then invoke the TLS userspace daemon to run the TLS
> handshake.
> If the TLS handshake succeeds the userspace daemon will be activating
> kTLS on the socket, and control is passed back to the kernel.
> 
> This implementation currently does not implement the so-called
> 'secure concatenation' mode from NVMe-TCP; a TPAR is still pending
> with fixes for it, so I'll wait until it's published before
> posting patches for that.
> 
> Patchset can be found at:
> git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
> branch tls.v16
> 
> For testing I'm using this script, running on a nvme target
> with NQN 'nqn.test' and using 127.0.0.1 as a port; the port
> has to set 'addr_tsas' to 'tls1.3':
> 
> modprobe nvmet-tcp
> nvmetcli restore
> modprobe nvme-tcp
> ./nvme gen-tls-key --subsysnqn=nqn.test -i
> ./nvme gen-tls-key --subsysnqn=nqn.2014-08.org.nvmexpress.discovery -i
> tlshd -c /etc/tlshd.conf
> 
> and then one can do a simple:
> # nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.test --tls
> to start the connection.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v10:
> - Include reviews from Sagi
> 
> Changes to v9:
> - Close race between done() and timeout()
> - Add logging message for icreq/icresp failure
> - Sparse fixes
> - Restrict TREQ setting to 'not required' or 'required'
>    when TLS is enabled
> 
> Changes to v8:
> - Simplify reference counting as suggested by Sagi
> - Implement nvmf_parse_key() to simplify options parsing
> - Add patch to peek at icreq to figure out whether TLS
>    should be started
> 
> Changes to v7:
> - Include reviews from Simon
> - Do not call sock_release() when sock_alloc_file() fails
> 
> Changes to v6:
> - More reviews from Sagi
> - Fixup non-tls connections
> - Fixup nvme options handling
> - Add reference counting to nvmet-tcp queues
> 
> Changes to v5:
> - Include reviews from Sagi
> - Split off nvmet tsas/treq handling
> - Sanitize sock_file handling
> 
> Changes to v4:
> - Split off network patches into a separate
>    patchset
>      - Handle TLS Alert notifications
> 
> Changes to v3:
> - Really handle MSG_EOR for TLS
> - Fixup MSG_SENDPAGE_NOTLAST handling
> - Conditionally disable fabric option
> 
> Changes to v2:
> - Included reviews from Sagi
> - Removed MSG_SENDPAGE_NOTLAST
> - Improved MSG_EOR handling for TLS
> - Add config options NVME_TCP_TLS
>    and NVME_TARGET_TCP_TLS
> 
> Changes to the original RFC:
> - Add a CONFIG_NVME_TLS config option
> - Use a single PSK for the TLS handshake
> - Make TLS connections mandatory
> - Do not peek messages for the server
> - Simplify data_ready callback
> - Implement read_sock() for TLS
> 
> Hannes Reinecke (18):
>    nvme-keyring: register '.nvme' keyring
>    nvme-keyring: define a 'psk' keytype
>    nvme: add TCP TSAS definitions
>    nvme-tcp: add definitions for TLS cipher suites
>    nvme-keyring: implement nvme_tls_psk_default()
>    security/keys: export key_lookup()
>    nvme-tcp: allocate socket file
>    nvme-tcp: enable TLS handshake upcall
>    nvme-tcp: control message handling for recvmsg()
>    nvme-tcp: improve icreq/icresp logging
>    nvme-fabrics: parse options 'keyring' and 'tls_key'
>    nvmet: make TCP sectype settable via configfs
>    nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
>    nvmet-tcp: allocate socket file
>    nvmet: Set 'TREQ' to 'required' when TLS is enabled
>    nvmet-tcp: enable TLS handshake upcall
>    nvmet-tcp: control messages for recvmsg()
>    nvmet-tcp: peek icreq before starting TLS
> 
>   drivers/nvme/common/Kconfig    |   4 +
>   drivers/nvme/common/Makefile   |   3 +-
>   drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++
>   drivers/nvme/host/Kconfig      |  15 ++
>   drivers/nvme/host/core.c       |  12 +-
>   drivers/nvme/host/fabrics.c    |  67 ++++++-
>   drivers/nvme/host/fabrics.h    |   9 +
>   drivers/nvme/host/nvme.h       |   1 +
>   drivers/nvme/host/sysfs.c      |  21 +++
>   drivers/nvme/host/tcp.c        | 184 ++++++++++++++++--
>   drivers/nvme/target/Kconfig    |  15 ++
>   drivers/nvme/target/configfs.c | 128 ++++++++++++-
>   drivers/nvme/target/nvmet.h    |  11 ++
>   drivers/nvme/target/tcp.c      | 334 ++++++++++++++++++++++++++++++---
>   include/linux/key.h            |   1 +
>   include/linux/nvme-keyring.h   |  36 ++++
>   include/linux/nvme-tcp.h       |   6 +
>   include/linux/nvme.h           |  10 +
>   security/keys/key.c            |   1 +
>   19 files changed, 991 insertions(+), 49 deletions(-)
>   create mode 100644 drivers/nvme/common/keyring.c
>   create mode 100644 include/linux/nvme-keyring.h
> 

