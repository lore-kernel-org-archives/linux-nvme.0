From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 26 Sep 2018 11:30:19 -0600
Subject: Can not set SMP affinity on kernels above 3.10.0-514
In-Reply-To: <CAHC07GSK=-_c-9pmRb60iyfvbzqD53NYai_muLUajJsj4O7wig@mail.gmail.com>
References: <CAHC07GSK=-_c-9pmRb60iyfvbzqD53NYai_muLUajJsj4O7wig@mail.gmail.com>
Message-ID: <20180926173019.GA17405@localhost.localdomain>

On Wed, Sep 26, 2018@10:38:12AM -0600, Brian Atkinson wrote:
> I am currently receiving the following error whenever I go to adjust
> the smp_affinity/smp_affinity_list files for IRQ's associated the
> Samsung NVMe SDD PM1725a installed in a Dell PowerEdge R7425 server:
> 
> echo: write error: Input/output error
> 
> I have stopped/disabled irqbalance using the following:
> 
> systemctl stop irqbalance
> systemctl disable irqbalance
> 
> However, I still get the Input/output error when I try and echo any
> values into either the smp_affinity or smp_affinity_list files. What
> is really peculiar about this, is I have no issues updating the values
> in these files as long as I am on the stock kernel 3.10.0-514 that
> came with CentOS 7.3; however, whenever I get this error on the
> following kernels 3.10.0-862.11.6, 4.4.153-1, and 4.18.5-1. Since I am
> only experiencing this issue in these newer kernels, I imagine there
> is some setting I do not have set that is preventing me from updating
> the SMP affinity values for the NVMe SDD's IRQ's. Has anyone else
> experienced this issue and possibly know how to correct it?

NVMe interrupts are kernel managed, which isn't changeable from
user space.
