Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF3C0218F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CD8OS0v/yDUliDZljFbLDPJ3YJ6X1i9bJSHN/SY1h0=; b=gWFlCxjn/J/mWn4AP1mFfqByPU
	zml9HwZvZeP5X+RLvKjEwTDwThDNfiTSVVX4A6L+/aUsBZ9ORSiZnWqZOVKGyp5Hos4szMSv4vUrr
	nHgHud0FvE9I9b/rpqRaq9j+eY0W75jScVRQpEFEoYWgulRnhyjJdAAst2A/jzLPTusGsUFUhzfVF
	T5F0Zl44Y/Pn7itVWbiB13FCMmJ37H5T5UTKoKfHmSTTPKQyznl/U8Q61Eh78tOpPGaFcf5JKMMi3
	azRTj42RTR3iULr4ggtVe1BCyPmUAxSdJ7ji8shhNo/AGRaHFyFJ+kQEl6eonppgubzj3qYOkWWgT
	/fDigiTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tekBJ-0000000EKPO-17Vu;
	Mon, 03 Feb 2025 00:19:17 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tekBG-0000000EKOy-1Bcu
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 00:19:16 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so782927a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 02 Feb 2025 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738541953; x=1739146753; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CD8OS0v/yDUliDZljFbLDPJ3YJ6X1i9bJSHN/SY1h0=;
        b=ex5bNNHTTEpNV8b78FNf5GaU5O5l92bW4NpbMRCagyZyHs+Fqeg+8i6B9Ht4QisAMR
         duDGav+cGufF/8r/6+EKFEzOLm2T6b3Alg0hnt3cTsV4lPC6AtYcYAB4EUY2ATf9Rk97
         Ecd1USJCjAGTT2+GPF7MeiPuLdm8HV0+gHio5RzcOHac6MCZ/wEiY2aYNKc7muF+CZLe
         +2qhr82wWcCDuSHTPtWP0hE8GWxyLg0SojtHI3qwSBLeSlsqX8CF+e7I/ZvDrgVc1hf9
         Az43M03MvXTE9qQbD1gQ6zUe33i9V8uuzjQgISqkvAR3fZ4LaijLFWjsLefT/CW7NqZC
         MYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738541953; x=1739146753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CD8OS0v/yDUliDZljFbLDPJ3YJ6X1i9bJSHN/SY1h0=;
        b=FoxgHXs37ezoD1iQDIsDCVaACIAHC6QPlOcKgRoz+C1CACX2kjXk2OZfhdjB3eGTz/
         dG7g3GAqEj4JsVGfMnuQGf8OjV7EHfP44cZDWpfo0w1/4RojGpRixe81uxPnn5kGvU5R
         lJLV5XhvWNDfQC9Dfbd5J04orRX++Ty8PxskLHnLwmcid41DyzbQqkmzbQ90FrqsnWDG
         jxOLeh/MSvF7Q7LMrbyL4lPc3Evw3nBhD/kWtKfhEGeWpFKgK8UTe6bWvR9XvfcHA47x
         /v1fwflaA4H3z1G4ERF4iy4HxuOn0H699akf3XnUdhCsoGOG+aS2e8YehJgEaH74DJLb
         tZpw==
X-Forwarded-Encrypted: i=1; AJvYcCVg5nEuOUo/3t40IPbic4CKA9UMnBty3BLuKRvlPc5KvgfBXOXd5BvkxKBLX6rbbkYv7m58mST6N5lq@lists.infradead.org
X-Gm-Message-State: AOJu0YzQVl68HetthT6YtlxNYI0s7kOf5Fn9JyTKl3ef+df/byk4T0Rs
	9KG6fd0L/7+QDZW1bdcHrUquaM3Y0cjnDhJEW9FVL0iiUjcoJ0DP27huZECnoBiuPLWaP5WvwI2
	PgAZnx3NK3E8psmT0zkGKrJ1cdqrackD9PpY2kw==
X-Gm-Gg: ASbGncvA1Z/I750fD1Pap4vTXGkUDN9sJiN70KY0M/lXjtK2sqYRCwQW6hFtSXuqeT/
	qOaKq4nhdX6eybTsrdm1jU+S3UO2LdtcQAFuDjgmZtWfO4dVFN6NmQJQXoGk03q7xTcOsOzE=
X-Google-Smtp-Source: AGHT+IFmzoWCYaEfo5enZeTMzTrar2GW00RaNdMzCm+dxuNCQvwT32LxLfM4mpkC355ACLYCKpn75ZVcF4TOn8qxYt0=
X-Received: by 2002:a17:90b:2cc3:b0:2ea:bb3a:8f09 with SMTP id
 98e67ed59e1d1-2f83aa65d88mr11673305a91.0.1738541952924; Sun, 02 Feb 2025
 16:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de> <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
In-Reply-To: <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Sun, 2 Feb 2025 16:19:01 -0800
X-Gm-Features: AWEUYZlJ4nSE-xwpmFAqYdPyI5t_TuDWsFBFF8tDUCGLXuTuUk3HguK3xGsbwmY
Message-ID: <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_161914_362387_26C7E724 
X-CRM114-Status: GOOD (  17.57  )
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

On Fri, Jan 31, 2025 at 12:17=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> w=
rote:
...
> Caleb, can you please make sure to test this patch with TLS?

Can you point me to some documentation for that? I tried setting up a
nvmet_tcp port to use TLS and connecting to it as described in the
cover letter for the patch series (https://lwn.net/Articles/941139/).
But the TLS Server Hello seems to fail with EACCES. Any idea what I'm
doing wrong?
$ modprobe nvmet_tcp
$ modprobe null_blk nr_devices=3D1
$ mkdir /sys/kernel/config/nvmet/subsystems/nqn.nvmet
$ echo 1 > /sys/kernel/config/nvmet/subsystems/nqn.nvmet/attr_allow_any_hos=
t
$ mkdir /sys/kernel/config/nvmet/subsystems/nqn.nvmet/namespaces/1
$ echo /dev/nullb0 >
/sys/kernel/config/nvmet/subsystems/nqn.nvmet/namespaces/1/device_path
$ echo 1 > /sys/kernel/config/nvmet/subsystems/nqn.nvmet/namespaces/1/enabl=
e
$ mkdir /sys/kernel/config/nvmet/ports/1
$ echo tcp > /sys/kernel/config/nvmet/ports/1/addr_trtype
$ echo ipv4 > /sys/kernel/config/nvmet/ports/1/addr_adrfam
$ echo 127.0.0.1 > /sys/kernel/config/nvmet/ports/1/addr_traddr
$ echo 4420 > /sys/kernel/config/nvmet/ports/1/addr_trsvcid
$ echo required > /sys/kernel/config/nvmet/ports/1/addr_treq
$ echo tls1.3 > /sys/kernel/config/nvmet/ports/1/addr_tsas
$ ln -s /sys/kernel/config/nvmet/subsystems/nqn.nvmet
/sys/kernel/config/nvmet/ports/1/subsystems
$ nvme gen-tls-key --subsysnqn nqn.nvmet --insert
Inserted TLS key 005e8a74
$ nvme gen-tls-key --subsysnqn nqn.2014-08.org.nvmexpress.discovery --inser=
t
Inserted TLS key 22d676b8
$ tlshd &
$ nvme discover --transport tcp --traddr 127.0.0.1 --trsvcid 4420 --tls
Failed to write to /dev/nvme-fabrics: Input/output error
failed to add controller, error failed to write to nvme-fabrics device

With debug logs enabled, I see the following:
$ dmesg | tail -6
[  440.405298] nvme nvme0: connecting queue 0
[  440.405403] nvmet_tcp: queue 0: TLS ServerHello
[  440.405433] nvme nvme0: queue 0: start TLS with key 11b456f9
[  440.407836] nvmet_tcp: queue 0: TLS handshake done, key 0, status -13
[  440.422881] nvme nvme0: queue 0: TLS handshake done, key 0, status -13
[  440.422932] nvme nvme0: queue 0: TLS handshake complete, error 13

A tcpdump shows the host sending a TLS Client Hello packet and the
target immediately closing the connection.

> Do you have a reliable way to reproduce this?

Sure, here's a fake Python NVMe/TCP controller that immediately closes
each connection after receiving the ICReq PDU:
```
import socket

def recv_all(socket, length):
    result =3D b''
    while len(result) < length:
        result +=3D socket.recv(length - len(result))
    return result

listen_sock =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
listen_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
listen_sock.bind(('', 4420))
listen_sock.listen()
while True:
    client_sock, _ =3D listen_sock.accept()
    recv_all(client_sock, 128) # ICReq
    client_sock.close()
```
Attempting to connect to it reports an error about the ICResp PDU type
field even though no ICResp was sent:
$ nvme connect --transport tcp --traddr 192.168.1.12 --nqn nqn.abc
Failed to write to /dev/nvme-fabrics: Invalid argument
could not add new controller: invalid arguments/configuration
$ dmesg | tail -1
[1351639.614853] nvme_tcp: queue 0: bad type returned 0

Here's a valid scenario where the controller sends the ICResp Common
Header and PDU Specific Header separately (using TCP_NODELAY to ensure
the sends are not coalesced):
```
import socket

def recv_all(socket, length):
    result =3D b''
    while len(result) < length:
        result +=3D socket.recv(length - len(result))
    return result

def send_all(socket, data):
    while data:
        data =3D data[socket.send(data):]

listen_sock =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
listen_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
listen_sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
listen_sock.bind(('', 4420))
listen_sock.listen()
while True:
    client_sock, _ =3D listen_sock.accept()
    recv_all(client_sock, 128) # ICReq
    common_header =3D bytes([
        0x01, # PDU-type
        0, # FLAGS
        128, # HLEN
        0, # PDO
        128, 0, 0, 0, # PLEN
    ])
    send_all(client_sock, common_header)
    ic_resp =3D bytes([
        0, 0, # PFV
        0, # CPDA
        0, # DGST
        0xFC, 0xFF, 0xFF, 0xFF, # MAXH2CDATA
    ] + [0] * 112)
    send_all(client_sock, ic_resp)
    client_sock.close()
```
The host refuses to connect, complaining that the MAXH2CDATA field in
the ICResp is invalid. But that is because it only received the Common
Header.
$ nvme connect --transport tcp --traddr 192.168.1.12 --nqn nqn.abc
Failed to write to /dev/nvme-fabrics: Invalid argument
could not add new controller: invalid arguments/configuration
$ dmesg | tail -1
[1351960.082011] nvme_tcp: queue 0: invalid maxh2cdata returned 0

With the patch applied, the controller closing the connection without
sending a ICResp PDU correctly results in a "Connection reset by peer"
error:
$ nvme connect --transport tcp --traddr 192.168.1.12 --nqn nqn.abc
Failed to write to /dev/nvme-fabrics: Connection reset by peer
could not add new controller: failed to write to nvme-fabrics device
$ dmesg | tail -1
[  450.050463] nvme_tcp: queue 0: failed to receive icresp, error 0

And when the controller sends the Common Header separately from the
PDU Specific Header, nvme_tcp_init_connection() now succeeds. The
connection attempt instead times out waiting for a response to the
Fabrics Connect command, since the fake NVMe/TCP controller doesn't
implement that:
$ nvme connect --transport tcp --traddr 192.168.1.12 --nqn nqn.abc
Failed to write to /dev/nvme-fabrics: Input/output error
could not add new controller: failed to write to nvme-fabrics device
$ dmesg | tail -3
[  644.728894] nvme nvme0: I/O tag 0 (0000) type 4 opcode 0x7f
(Connect) QID 0 timeout
[  644.728974] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[  644.728999] nvme nvme0: failed to connect queue: 0 ret=3D881

Thanks,
Caleb

