From: keith.busch@intel.com (Keith Busch)
Date: Fri, 1 Mar 2013 15:05:06 -0700 (MST)
Subject: [PATCH 2/2] Return the result from user admin command IOCTL even
 in case of failureX
In-Reply-To: <E821E2F372F08945977BD15EAE588D61097C57F2@SACMBXIP02.sdcorp.global.sandisk.com>
References: <E821E2F372F08945977BD15EAE588D61097C57F2@SACMBXIP02.sdcorp.global.sandisk.com>
Message-ID: <alpine.LRH.2.03.1303011459080.456@localhost.localdom>

On Thu, 28 Feb 2013, Chayan Biswas wrote:
> -       if (!status && copy_to_user(&ucmd->result, &cmd.result,
> -                                                       sizeof(cmd.result)))
> +       if (copy_to_user(&ucmd->result, &cmd.result, sizeof(cmd.result)))
>                status = -EFAULT;

I think you want to change this to a check for 'status >= 0' before
copying the result to the user since a status < 0 means the command was
not completed by the controller (successfully or otherwise) and you'd
be copying uninitialized data to the user in that case.
