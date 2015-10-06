From: cknvme@gmail.com (royy walls)
Date: Tue, 6 Oct 2015 14:35:31 -0700
Subject: Command Effects log support in NVMe Driver.
Message-ID: <CAGrovxVrJM8QxSquUraTPSor23oikKqD7mRzNTfGqSiK74Z-Dw@mail.gmail.com>

Hi,

Our proposal is to have the nvme driver act on the information
provided by the command effects log, instead of replying on other user
space management applications. For example, the driver would read and
store the command effects log during device initialization. Any
commands issued after this would be looked up in the stored command
effects log data and recommended actions would automatically
happen.i.e. restricting concurrent access to a namespace,
re-enumerating namespaces, etc..

Regards,
Royy
