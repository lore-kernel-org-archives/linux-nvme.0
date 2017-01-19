From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 19:00:44 -0800
Subject: [PATCH 05/17] lpfc: NVME Initiator: Base modifications Part D
In-Reply-To: <20170118133959.GE3514@linux-x5ow.site>
References: <587ec2f0.FOr4W1UKpsGdXJmP%jsmart2021@gmail.com>
 <20170118133959.GE3514@linux-x5ow.site>
Message-ID: <8d1b6a73-df1a-1fd1-5059-7ce6a7e91c6f@gmail.com>


On 1/18/2017 5:39 AM, Johannes Thumshirn wrote:
> I know this might be annoying by now, but it's really hard to follow 
> code that
> is so much indented and lpfc really needs some love in the readability case.
> Please don't misunderstand me, it has nothing to do with you and lpfc is not
> the only driver that could need some refactoring. It's just I've spend a lot
> of time looking at lpfc since I've started working in the storage area and
> the code style is somewhat inconsistent with the reset of the kernel (as are
> other SCSI drivers, I know). If you and Martin/James B. don't mind I'd even
> volunteer to help you with cleaning it up a bit.

I agree with the idea but want to hold off a little while longer. first, 
I want the driver to stabilize after adding a second protocol. second, I 
want it to harden a bit.

-- james
