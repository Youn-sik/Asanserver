import { Component } from 'react';
import { BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import Dash from './views/dash/dash';
import Schedule from './views/reg/schedule';

class App extends Component {
  render() {
    return (
      <>
        <Router>
          <Routes>
            <Route exact path = "/" element = {<Dash/>} />
            <Route path = "/register" element = {<Schedule/>} />
          </Routes>
        </Router>
      </> 
    );
  }
}

export default App;
