![P4D Logo](https://github.com/pyscripter/python4delphi/wiki/Images/Python4Delphi(wide-transparent).png)

[Python](https://www.python.org) for [Delphi](https://www.embarcadero.com/products/delphi) (P4D) is a set of free components that wrap up the Python DLL into Delphi and Lazarus (FPC). They let you easily execute Python scripts, create new Python modules and new Python types. You can create Python extensions as DLLs and much more. P4D provides different levels of functionality:

  * **Low-level access to the python API**
  * **High-level bi-directional interaction with Python**
  * **Access to Python objects using Delphi custom variants (VarPyth.pas)**
  * **Wrapping of Delphi objects for use in python scripts using RTTI (WrapDelphi.pas)**
  * **Creating python extension modules with Delphi classes and functions**

P4D makes it very easy to use python as a scripting language for Delphi applications. It also comes with an extensive range of demos and tutorials.

### How to use Python4Delphi ###

The best way to learn about how to use Python for Delphi is to try the extensive range of demos available.  Also studying the unit tests for VarPyth and WrapDelphi can help understand what is possible with these two units.

### Wiki topics
- [Installation](https://github.com/pyscripter/python4delphi/wiki/Installation)
- [Supported Platforms](https://github.com/pyscripter/python4delphi/wiki/SupportedPlatforms)
- [How Python for Delphi finds your Python distribution](https://github.com/pyscripter/python4delphi/wiki/FindingPython) (read before trying the demos)

### Learn about Python for Delphi
- [Tutorials](https://github.com/pyscripter/python4delphi/tree/master/Tutorials) 
- [Demos](https://github.com/pyscripter/python4delphi/tree/master/Demos)

### Support forum

Visit the [support forum](https://en.delphipraxis.net/forum/39-python4delphi/) to ask questions and discuss P4D related issues.

### License
The project is licensed under the MIT [license](https://github.com/pyscripter/python4delphi/blob/master/LICENSE).

### maXbox Integration
On maXbox4 theres a scripting integration with Eval and Ecec.
The eval() is not just limited to simple expression. We can execute functions, call methods, reference variables and so on.
For instance you can install packages from your script:
eng.ExecString(‘import subprocess’);
eng.ExecString(‘subprocess.call([“pip”, “install”, “langdetect”])’)
eng.ExecString(‘from langdetect import detect’);
println(‘detect: ‘+eng.EvalStr(‘detect(“bonjour mes ordinateurs”)’));
>>> detect: fr

The minimal configuration depends on your Python-installation and the UseLastKnownVersion property 
in TDynamicDll but once known it goes like this with raiseError to get the Python exceptions:
	
with TPythonEngine.Create(Nil) do begin
  pythonhome:= PYHOME;
  try
    loadDLL;
    Println('Decimal: '+ 
          EvalStr('__import__("decimal").Decimal(0.1)')); 
  except
    raiseError;        
  finally       
    free;
  end; 
end;    

https://maxbox4.wordpress.com/2021/07/28/python4maxbox-code/


