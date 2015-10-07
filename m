From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Oct 2015 16:59:44 +0000 (UTC)
Subject: Command Effects log support in NVMe Driver.
In-Reply-To: <CAGrovxVrJM8QxSquUraTPSor23oikKqD7mRzNTfGqSiK74Z-Dw@mail.gmail.com>
References: <CAGrovxVrJM8QxSquUraTPSor23oikKqD7mRzNTfGqSiK74Z-Dw@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1510071650250.23840@localhost.lm.intel.com>

On Tue, 6 Oct 2015, royy walls wrote:
> Our proposal is to have the nvme driver act on the information
> provided by the command effects log, instead of replying on other user
> space management applications. For example, the driver would read and
> store the command effects log during device initialization. Any
> commands issued after this would be looked up in the stored command
> effects log data and recommended actions would automatically
> happen.i.e. restricting concurrent access to a namespace,
> re-enumerating namespaces, etc..

It sounds reasonable, but it's not a complete solution. What if you
submit a namespace attachment command from one host, attaching it to a
different controller in the subsystem? There's no action the driver can do
to help from knowing the command effects. I think maybe the action should
be taken by the user space that sent the command in the first place.
