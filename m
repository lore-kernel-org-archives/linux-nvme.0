Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC68C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 21:39:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4D361007
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 21:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4D361007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=heZnT4obH00RvS1KLvEjW5iYvRVuphafINllJS72uNI=; b=PX8SZfv//arkaKuojWtntfWy5
	/OXFUvQDnswABQHudKoO8cHigQTgjaGQdhNfFfLH2wMtE6lbyU9trlePQgPbrS/noXSq7rvi3Ub+W
	tlgwk2B+e+OmL+qi3+nsCpRMdek3WZhycEG77QAMXyKagyyhHvSvWVEv+hkZEfXW083o1158E9OD6
	VsIMZSULp4xQ64tXBZKv+GZ1i+yLH/q+Sp8ozLz3yhELPyuTnuhPBTvzhodWv0crOI2oUNGe28cmy
	KsPWUQuQlEcqCHAW8JFB6SDrX+g0yC4Sxk2yCMmfTdKsoZEOh/taedXdARbwO8TCuE5fFt1RW5uoI
	7mBdRbQZQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUyq1-001Z4U-MQ; Fri, 09 Apr 2021 21:38:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUypw-001Z3v-0W
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 21:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=WNiTOehnE92nfZCHDH5sCr/MKnxoz9tSCPdO5lW529Y=; b=ybkzAGZrFf1BWeu16YWBrVMWU0
 hGKwD3htVxJV+g1jNBYGpQ0r8JsvbPN2kAJDIMJWEqe6aDr9yfqVIRmW4kfqiLnlfDnhiraCg968g
 YOu1iu5RB63NJIKXSMhPvgX96AceP53xctSfqogAVxv2ORcWau4WYSxBtvQpvsXUbYCK61uMGBxZk
 3HJzyqttac95BETYmDZkK3PrKnlIwWxk3dm/oOhDIhhLZRzNDDUCDot/woYfVJP5x4045/DgB16XI
 Hfi2KzBRD09tMlGaqYR+QZt0jg9XKZlmtNsVR3Ieam7xHaYmrplX8lENwnOU8C2MT1smfoHweRjHY
 dyQGvo2Q==;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUypt-004oXI-9N
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 21:38:42 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 lr1-20020a17090b4b81b02900ea0a3f38c1so7068966pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 14:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WNiTOehnE92nfZCHDH5sCr/MKnxoz9tSCPdO5lW529Y=;
 b=Lk5vYJhXsKYtzCY4ZCFVw7+bUBgFo3nAqLHxTsDcGVWjB7faZhX9e6DTY98lf/xmDR
 6dXPqr0yFzHFCDRwGFFdKp0XxSCNKXNLzLzXn8SQFTxjgLz2FZZ6jQyBWcSb/gPqQoMU
 TrMOo8EiVOhoTmDpk9JjbBGsKHKlQ5ay5JVzrs8VHnyKwFuNa65l+1IiwEc+CQnMIW1/
 B7Ze1B9QuFULZHViXGrSpIo6eRXSXwDCk0+tPDYsszeZ7FbRAx1qJKMzODjWw9QGIpRP
 fA0a2CJsmktardVxkgdnTWFSFgx/oEJG8Jme8kOthmEUr9GcgGGE2w9XZ+QLnQGkeB/1
 kM2w==
X-Gm-Message-State: AOAM533vEkle3O/o4CZ9jPxKqqZRH9I9XcFGizMjWqFsvUWhARq+MYB8
 89whXphjBKwhlbi1gs14X+sHrCyMa+o=
X-Google-Smtp-Source: ABdhPJxKT6i+eyJ520iuAHRiqZS38y4sfstlHzjrOq/AzeRaREhTR+nCbWoKVI29jvttfjHvBw9x6Q==
X-Received: by 2002:a17:90a:550f:: with SMTP id
 b15mr15995180pji.102.1618004320244; 
 Fri, 09 Apr 2021 14:38:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95dd:20b7:6d40:bdc3?
 ([2601:647:4802:9070:95dd:20b7:6d40:bdc3])
 by smtp.gmail.com with ESMTPSA id 81sm3079184pfu.164.2021.04.09.14.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 14:38:39 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
Date: Fri, 9 Apr 2021 14:38:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_143841_362905_63AA0D91 
X-CRM114-Status: GOOD (  20.20  )
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


>>>>> This was observed on the recent 5.12-rc4, so it has all the latest tcp
>>>>> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
>>>>> difference. It is currently reproducible, though it can take over an
>>>>> hour right now.
>>>>
>>>> After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
>>>
>>> Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
>>> This patch is actually needed.
>>>
>>>
>>>> We'll try adding it back, plust adding your debug patch.
>>>
>>> Yes, that would give us more info about what is the state the
>>> request is in when getting these errors
>>
>> We have recreated with your debug patch:
>>
>>    nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
>>
>> State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
>>
>> The summary from the test that I received:
>>
>>    We have an Ethernet trace for this failure. I filtered the trace for the
>>    connection that maps to "queue 6 of nvme4" and tracked the state of the IO
>>    command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
>>    the Ethernet trace is:
>>
>>     1. The target receives this Command in an Ethernet frame that has  9 Command
>>        capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
>>        operation for 16K IO size
>>     2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
>>        C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
>>        in the last PDU.
>>     3. The target sends a Response for this Command.
>>     4. About 1.3 ms later, the Host logs this msg and closes the connection.
>>
>> Please let us know if you need any additional information.
> 
> I'm not sure if this is just a different symptom of the same problem,
> but with the debug patch, we're occasionally hitting messages like:
> 
>    nvme nvme5: req 8 r2t len 16384 exceeded data len 16384 (8192 sent) cmd_state 2

According to this message, this means the host got an r2t for 16384
bytes after it already sent 8192 (which can only happen if it previously
got an r2t soliciting 8192 bytes or more that accumulate to that). Can
you share for each r2t pdus in this sequence:
r2t_length
r2t_offset

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
