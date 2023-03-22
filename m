Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A185DC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcfLk8cw/2p3N7aKlNuwPG0cuKZ2Kw10diUrp1mnJ3A=; b=CW9WEDxeSVO8notS0ifnqi8yd4
	80i3cNFejsp1fQnRnupalZSVyJWccyFu+BFdI8rdT5GtQCjL6tp57OCkhRqo4RzHqdZ3n1ZOO/u/V
	eBT/SFoHZsdPwQx087V7dlxJU3ilNRRZ0Ix9e7cKvvAIqC8ViH5uLz55wB1monfGRqXiDsa1WlQYm
	nXD23e3iPtkVMYobAj/5jQP+z4R7YrV3vvIjbY/bwVGrJDqNWAVT8S6aluLw4XZTXDNcltOOp7Tlg
	aoBj7R4oU1E8zcd2p1yWdwI9lEyK48+sg40T3kATHlqlDaiudjEyWbjTPSh5K7IcujBhxziLm443J
	GWRV6/Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peswM-00F0nS-1F;
	Wed, 22 Mar 2023 07:31:22 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peswJ-00F0mQ-2a
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 07:31:21 +0000
Received: by mail-wr1-f49.google.com with SMTP id v25so12509549wra.12
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470274; x=1682062274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcfLk8cw/2p3N7aKlNuwPG0cuKZ2Kw10diUrp1mnJ3A=;
        b=cZeAAqVBHAE37puzvqaXJc+MBaU5d7zH91r8vQo5gqoRfrU1xlvMI4AV6hCVKfTZwa
         igMxXOVfpCQSiLtUx1mhyfe1xi9Jzph6Aju1Gvldq+96JJAVSxG8G8EJYPm6TnFDDsDr
         jrzOb0WgPNWhnXo9UoVmnkb+A0wagY48G1AvKsXc4tw4/YE3NIpMML/M6F3lZq12eyvU
         9q7Ik5su/wcyXPpGNLWelOUWdTlSldJLTI21DRppfrki1ZoQuNzMw9fDIAplCjlm/HJV
         kx58CvdD/ZJltVuQ+Q5Q6e9fY0nKFhSd55C07A7LWKHPLA2xoHQH+K4P5rAoJujnyWzB
         d1xw==
X-Gm-Message-State: AO0yUKXQJaGrhC8Ty3aYmAw9NMRBz2SizQ/9Z3IwXFMlAxGEk0zQ6V/v
	AU4RFd+vFHNPyPZm1NBg2Di/EC2ISlI=
X-Google-Smtp-Source: AK7set+UxuK17yFX20aI+9ixMZkvP5foOFbMreNQHsccPEXU7hXbaXhY2lk9uMH0xu13yIbqCj2q8A==
X-Received: by 2002:adf:dbc8:0:b0:2c7:d80:ffc4 with SMTP id e8-20020adfdbc8000000b002c70d80ffc4mr3249320wrj.7.1679470274416;
        Wed, 22 Mar 2023 00:31:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm13303951wrr.79.2023.03.22.00.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:31:14 -0700 (PDT)
Message-ID: <2027b975-1c9e-eb92-e374-9719bad49869@grimberg.me>
Date: Wed, 22 Mar 2023 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] nvme fabrics polling fixes
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_003119_836576_6BBF9E0B 
X-CRM114-Status: GOOD (  10.61  )
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


> I couldn't test the existing tcp

It is very simple to do, for tcp you can just operate on the loopback
iface 127.0.0.1

See example:
$ ./target.sh 1 1
$ nvme connect-all -t tcp -a 127.0.0.1 -P 1

For rdma you can work on any interface you want, you just need
iproute with rdma utility (which is available with recent iproute
packages).

Setup Software RoCE:
$ rdma link add rxe0 type rxe netdev <iface>
Setup Software iWarp:
$ rdma link add siw0 type siw netdev <iface>

Then the same as before...
$ ./target.sh 1 1
$ nvme connect-all -t tcp -a <iface-addr> -P 1


That is essentially what blktest do.

target.sh
--
#!/bin/bash

# args: <num_subsys> <nr_ns-per-subsystem> <nvme|file>
# examples:
# - ./target.sh 1 1       # uses null_blk
# - ./target.sh 1 1 nvme
# - ./target.sh 1 1 file

CFGFS=/sys/kernel/config/nvmet
NQN=testnqn

mount -t configfs configfs /sys/kernel/config > /dev/null 2>&1

rm -f $CFGFS/ports/*/subsystems/*
rm -f $CFGFS/subsystems/*/allowed_hosts/* > /dev/null 2>&1
rmdir $CFGFS/subsystems/*/namespaces/* > /dev/null 2>&1
rmdir $CFGFS/subsystems/* > /dev/null 2>&1
rmdir $CFGFS/ports/* > /dev/null 2>&1
rmdir $CFGFS/hosts/* > /dev/null 2>&1

modprobe -r nvmet_rdma nvmet-tcp > /dev/null 2>&1
modprobe -r ib_umad rdma_ucm ib_uverbs rdma_cm > /dev/null 2>&1

modprobe -r null_blk nvme-tcp nvme-rdma
modprobe -r nvme-loop
rm -f /tmp/nsf*

if [[ $1 == "0" ]]; then
         exit
fi

modprobe null_blk nr_devices=$2 #queue_mode=0 irqmode=0
modprobe -a nvmet_tcp nvmet_rdma

mkdir $CFGFS/ports/1
echo 0.0.0.0 > $CFGFS/ports/1/addr_traddr
echo 8009 > $CFGFS/ports/1/addr_trsvcid
echo "tcp" >  $CFGFS/ports/1/addr_trtype
echo "ipv4" >  $CFGFS/ports/1/addr_adrfam

mkdir $CFGFS/ports/2
echo 0.0.0.0 > $CFGFS/ports/2/addr_traddr
echo 4420 > $CFGFS/ports/2/addr_trsvcid
echo "rdma" >  $CFGFS/ports/2/addr_trtype
echo "ipv4" >  $CFGFS/ports/2/addr_adrfam

mkdir $CFGFS/ports/3
echo "loop" >  $CFGFS/ports/3/addr_trtype

for j in `seq $1`
do
         mkdir $CFGFS/subsystems/$NQN$j
         echo 1 > $CFGFS/subsystems/$NQN$j/attr_allow_any_host
         k=0
         for i in `seq $2`
         do
                 mkdir $CFGFS/subsystems/$NQN$j/namespaces/$i
                 if [[ "$3" == "nvme" ]]; then
                         echo -n "/dev/nvme0n1" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 elif [[ "$3" == "file" ]]; then
                         ns="/tmp/nsf$k"
                         touch $ns
                         truncate --size=2G $ns
                         echo -n "$ns" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 else
                         echo -n "/dev/nullb$k" > 
$CFGFS/subsystems/$NQN$j/namespaces/$i/device_path
                 fi
                 echo 1 > $CFGFS/subsystems/$NQN$j/namespaces/$i/enable
                 let "k+=1"
         done
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/1/subsystems/
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/2/subsystems/
         ln -s $CFGFS/subsystems/$NQN$j $CFGFS/ports/3/subsystems/
done
--

