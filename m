From: indraneel.m@samsung.com (INDRANEEL MUKHERJEE)
Date: Thu, 12 Jun 2014 05:40:48 +0000 (GMT)
Subject: Questions on the correct Asynchronous Event Request Interface
Message-ID: <27590910.290271402551648565.JavaMail.weblogic@epml14>

A couple of patches have already been posted on the Asynchronous Event Request(AER) admin command.
But there is still no clarity on the what is the correct interface to the application.

Here'r some questions to help summarise the requirements & finalise an interface so that a patch can follow.
(References to kfifo are based on Keith's patch - http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html )

1. Should the Driver return both the Async Event Completion & the corresponding GetLogPage together to User Space?
This can help to avoid the Async Event getting masked accidently. It's possible that any Application reads the Async Event from kfifo but fails to read the corresponding Log Page masking the event indefinitely.

2. How to have provision in driver to set the 'Temperature Threshold' & 'Asynchronous Event Configuration' before sending the AER command?
This is needed as Spec says these should be set before the Async Event Request command is sent.
One way to achieve this is by making these module parameters and doing a SetFeature during Probe & Resume operations. If these module parameters are provided by user during insmod, driver should ensure that these are set before the kthread submits the AER.

3. Should the contents kfifo be preserved when the system goes into Suspend?

4. Only one application will get any event (kfifo ensures this). Is this expected?

5. How to have provision in the driver to cancel the current AER cmds and send new ones after doing some new Set Feature?
This will need the CmdIds for current AREs to be exported to User Space so that they can be aborted. Should the Driver support this?

6. Is the IOCtl interface enough? Or we want to keep the Read/Poll interface?

7. Is there any reference utility that can be looked at to see what such monitoring applications expect?

-Indro
