Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C7FC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Mar 2024 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3L2EA+YNKCvQ2Ttl7OGLsfvwDUJLh3ZJpf9J//3aCy0=; b=tYfAofCq4r52mWZei1xjATQu1B
	xOnISQ55ZAp94pSLVk0QaDIv+LP7ErrI9WPlBo6cn4P4tNEWub42xcmeuf/5BcC3yEAgBhvSOq5qq
	sYu/3Bw4ijJdZ86mGY+jVNGjVzrHLbHHSlBzxH6P6U3r+CtZ2PXkHn2ywoBzEXuGw9puTOwqB/UfY
	Hz5H+eUJ96eIjnKGnWB5KhymZggoIoNrE8BsMBVPmCZujtS4jiVjKXKdnzZYSSyRw/Q8cGIyCRRAQ
	/A7a6kGtZN+zyBrY+aOH0LHLba6DatQfDKs/k4hXdDDvOTuFkOAlrQcPKCKNL+rrwIdgI4TzpuXlJ
	KBkJq83Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rosyT-00000002Ewi-47uk;
	Mon, 25 Mar 2024 22:39:25 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rosyP-00000002EtT-2TJj
	for linux-nvme@lists.infradead.org;
	Mon, 25 Mar 2024 22:39:23 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ecdffd9e7so921641f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Mar 2024 15:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406359; x=1712011159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L2EA+YNKCvQ2Ttl7OGLsfvwDUJLh3ZJpf9J//3aCy0=;
        b=FZkiDLX9I3DaLANAnZidi0t3mzlVO7WHZxf87q/IMuKWxf1T6+d1/lWAO2eUoDKdxB
         Vj1nQhTREeJSM3SfZpNMd1z6gjAFdEM16YM6qsX7mENqeuq3mDEo94QaLmIvfa28+dME
         RFe8raNdwFgvfL/aF0SYlSskSHQRXx37suVdb/K+Dbs/nAJ340VFXUyT+jAHLbcqJMgW
         n2ubSCyC7W6uUkmuxCLRIaJTbTa/7y4w2uSIF1tXGP74uujDDc8HaQNytCdssNxMI5zv
         y13O8m6FcX73uCVhRztQqzPFGEiiEWf/+GFhHdxmC/1RDhY5Ib6zfw0/HRKTlM5EMo4a
         8qbg==
X-Forwarded-Encrypted: i=1; AJvYcCUu7RMIAVoqll3Qdm3RotEPArGdGOLv422mIkKXCc3CYtPiiBALRrgMP8G/G8aXysnNIQ+nH9c6fjoyd+5a3x+lokodS95VO4M0F3k5S4s=
X-Gm-Message-State: AOJu0YwfuM9XSXB2PBrl5tKQB2+dbw/kPC3avZLxh+Q7YQyunzoXzWm9
	SWUiGniPGHfbZ0Nd4aQ0c6Gpy2HI2T95vL75r4holTzso0K617/8
X-Google-Smtp-Source: AGHT+IGT9yDxxPXxeXqDUlfnwYXlP68xFA7CBM1IR6ct3nV+42E8Jki4Gn2Qpi7gRBWF7p+cBmkdqg==
X-Received: by 2002:a5d:6708:0:b0:33b:48ed:be63 with SMTP id o8-20020a5d6708000000b0033b48edbe63mr4852545wru.7.1711406358642;
        Mon, 25 Mar 2024 15:39:18 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d4c4d000000b0033fc06f2d84sm10497352wrt.109.2024.03.25.15.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:39:18 -0700 (PDT)
Message-ID: <26556198-2be3-4a73-b435-bfe3c72d7870@grimberg.me>
Date: Tue, 26 Mar 2024 00:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org,
 Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_153921_710958_20BEE300 
X-CRM114-Status: GOOD (  18.55  )
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



On 25/03/2024 20:18, Daniel Wagner wrote:
> On Fri, Mar 22, 2024 at 08:03:26AM +0100, Hannes Reinecke wrote:
>> +static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
>> +				      size_t count, loff_t *ppos)
>> +{
>> +	struct seq_file *m = file->private_data;
>> +	struct nvmet_ctrl *ctrl = m->private;
>> +	char reset[16];
>> +
>> +	if (count >= sizeof(reset))
>> +		return -EINVAL;
>> +	if (copy_from_user(reset, buf, count))
>> +		return -EFAULT;
>> +	if (!memcmp(reset, "fatal", 5))
>> +		nvmet_ctrl_fatal_error(ctrl);
> I'd like to use this also to trigger a reset. This allows to test the
> auth code a bit better, e.g. after changing the ctrl key on the target
> nothing will happen until a reconnect happens. Currently, I have to
> set the max queue count which triggers a reset. Also it would make the
> 'support real hardware' series for blktests why more generic.
>
> This here should does the trick in my local testing:
>
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -157,6 +157,8 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
>                  return -EFAULT;
>          if (!memcmp(reset, "fatal", 5))
>                  nvmet_ctrl_fatal_error(ctrl);
> +       else if (!memcmp(reset, "reset", 5))
> +               ctrl->ops->delete_ctrl(ctrl);
>          else
>                  return -EINVAL;
>          return count;

What is the difference between fatal and reset?

