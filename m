Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E37C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVg2HPUTolAL0oQkx82CizjZZR+M33PW8gxh0lT9X/U=; b=N+0HGrQQopWsAR7ROy3XmcdHzg
	+92r4n0oi5W/US78UdngodFTHtrUnGQPclkEQFxi+w2p3cs5qx/V/QVD8cN3jRx3xs8rB0Ion0Sgt
	R7odvPk5oA9FaGdD1+cYBf/C44+xvOtTR/oCGLf34/8T9mzF+5GJm4Kt/yfnGuHgxztOd8yMxqGSR
	RcmarXm9FtpX7ZN9TICHh9gGcjRdWqsDq0v8yBEuLcZF45fynkMAxfDAJ5775kJA7xTPn2aUFroTS
	ReC9iNITVNYEV3hD7Oi997TW31fIxrr0YSLVAYvscq1z21ek3RkalJPxaIurRPsMoqwesa6oZunTd
	YWZoGLww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbSTQ-00GHhX-LO; Mon, 04 Apr 2022 19:34:48 +0000
Received: from out1.migadu.com ([91.121.223.63])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbSTM-00GHh8-Ew
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 19:34:46 +0000
Message-ID: <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1649100880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVg2HPUTolAL0oQkx82CizjZZR+M33PW8gxh0lT9X/U=;
 b=TGlcbp52gHqtGsdns5Xv7vhrS+GNZQJ1pI7ko+VwM660Ml+KLrTeluvG9vjsyq9PSBB0Oe
 LLxovY9AQlFgq72SDNCJhBXYE6VwWs0joxEe3dZw3R1j+h1E35WHihDuUUytfYz9QaJG/C
 eAPo8dQvNhHQzlyO4nppIeOdc1FnVNo=
Date: Mon, 4 Apr 2022 13:34:38 -0600
MIME-Version: 1.0
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_123444_945849_8F97D4A8 
X-CRM114-Status: GOOD (  14.67  )
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



On 4/4/2022 11:02 AM, Keith Busch wrote:
> On Mon, Apr 04, 2022 at 04:39:06PM +0000, Alan Adamson wrote:
>>
>> [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
>>
>> An error from the device (status=2/Invalid Field) when an Identify (0x6) command was issued. Prior to the patch,
>> the nvme driver didn’t display the error.
>   
> And it's harmless. The driver is querying an optional identification and it's
> okay if the device doesn't support it, but the driver doesn't know if the
> device supports until it tries it.
I've had to field bug reports like this before, where it says error in 
dmesg but is actually harmless.

Maybe we could suppress the error and add a harmless print?
Eg, nvme0: blah blah command set not supported


>   
>>> On Apr 3, 2022, at 7:28 AM, Yi Zhang <yi.zhang@redhat.com> wrote:
>>>
>>> Hello
>>>
>>> I found this error log during blktests[1] with the latest
>>> linux-block/for-next, seems it was introduced after commit[2], is that
>>> expected?
>>>
>>> [1]
>>> [   96.931911] run blktests nvme/004 at 2022-04-02 20:53:16
>>> [   97.024693] loop: module loaded
>>> [   97.029319] loop0: detected capacity change from 0 to 2097152
>>> [   97.039641] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>> [   97.068847] nvmet: creating nvm controller 1 for subsystem
>>> blktests-subsystem-1 for NQN
>>> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
>>> [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
>>> [   97.090108] nvme nvme0: creating 32 I/O queues.
>>> [   97.098283] nvme nvme0: new ctrl: "blktests-subsystem-1"
>>> [   98.136900] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
>>>
>>> [2]
>>> commit bd83fe6f2cd2133beaac7c423fd36c3515048fc8
>>> Author: Alan Adamson <alan.adamson@oracle.com>
>>> Date:   Thu Feb 3 00:11:53 2022 -0800
>>>
>>>     nvme: add verbose error logging
>>>
>>> -- 
>>> Best Regards,
>>>   Yi Zhang
>>>
>>
> 

