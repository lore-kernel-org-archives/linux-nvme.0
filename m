From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 8 May 2018 14:44:43 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
Message-ID: <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>

Hi Dan

>    It seems unwieldy that this is a compile time option and not a runtime
>    option. Can't we have a kernel command line option to opt-in to this
>    behavior rather than require a wholly separate kernel image?
  
I think because of the security implications associated with p2pdma and ACS we wanted to make it very clear people were choosing one (p2pdma) or the other (IOMMU groupings and isolation). However personally I would prefer including the option of a run-time kernel parameter too. In fact a few months ago I proposed a small patch that did just that [1]. It never really went anywhere but if people were open to the idea we could look at adding it to the series.
  
> Why is this text added in a follow on patch and not the patch that
>  introduced the config option?

Because the ACS section was added later in the series and this information is associated with that additional functionality.
    
> I'm also wondering if that command line option can take a 'bus device
> function' address of a switch to limit the scope of where ACS is
> disabled.

By this you mean the address for either a RP, DSP, USP or MF EP below which we disable ACS? We could do that but I don't think it avoids the issue of changes in IOMMU groupings as devices are added/removed. It simply changes the problem from affecting and entire PCI domain to a sub-set of the domain. We can already handle this by doing p2pdma on one RP and normal IOMMU isolation on the other RPs in the system.

Stephen

[1] https://marc.info/?l=linux-doc&m=150907188310838&w=2
    
